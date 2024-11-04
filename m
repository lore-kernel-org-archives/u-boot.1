Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D360AD132CC
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CAF989000;
	Mon,  4 Nov 2024 14:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bdOwPdSn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DBD188EAB; Mon,  4 Nov 2024 14:56:12 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F1CD88936
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b14443a71eso375347385a.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730728569; x=1731333369; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zzg/oGZu4g2kS47L3s18hTcD8/c+KbXVp4iEpz/inH0=;
 b=bdOwPdSnQWSzxy0dd5wx6+UqPdJVYcilLwcxdqGFYglWKwop0hiDGN3qRtXyALTVs1
 6CZYuOYOvfzaIDv6TuCNjF4/VAKOwxFKxUeQsTycK153Xc+XEaEgP3xzfOFDJhTN5Fpo
 QVrs1EgRxKyXPSXGZRMtLuAPggeMH5CPtOQYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728569; x=1731333369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zzg/oGZu4g2kS47L3s18hTcD8/c+KbXVp4iEpz/inH0=;
 b=GMQbvqlzN1GDbJMtR90niAhiBUgVrDd53scDQoDwbTnu8qNET9YRxDkgcRWLzZAQ4/
 JrG9Vriy2q9LXu4HiEXRHwsa4nK2lZ5J3EmyCki6zBo7L/qTjlSCCVKKSMO93tQjt4jJ
 UqpYk7xQF0llZiYTPYeJLR38DroKj0QSkkoxAQRTdgKgCJdue7ZnphzSuW0qgQkL/3qM
 ibOVydzvjTt+tBynuJIvk9EbGmPLKL0Rrc1a62KsYxP+weAmPOswQ33HLKqJ5v0w83bA
 BbpiMwDNRvNpWbpCVT6ul4GmiHssBThSBEaz8j4IQbPRQmw5hLsgXuBuxDZzY50uQwF4
 KD7Q==
X-Gm-Message-State: AOJu0Yz9dqYOPKQhO7HtR4FFNdM9GnnyCBUyfN1i9eli6RzZzkCxRJaW
 //rQYpx/Km/ERMndhRopiXdk27lIlt0YBlQ7hG9Lcz9TzJmdiVNpcqgledZuIdU=
X-Google-Smtp-Source: AGHT+IFqHk5+vT3DMOVQoATZ5+TghxwRcNXwAm6Qkc76u6lRPtZsp20A3wTSRs3xghX1LYgd0N6jSw==
X-Received: by 2002:a05:620a:2908:b0:7b1:54e5:6183 with SMTP id
 af79cd13be357-7b2fb9d8775mr2152639085a.53.1730728569033; 
 Mon, 04 Nov 2024 05:56:09 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a816afsm420316885a.101.2024.11.04.05.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:56:08 -0800 (PST)
Date: Mon, 4 Nov 2024 07:56:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 4/9] docker: Adjust packages for arm64
Message-ID: <20241104135605.GJ3600562@bill-the-cat>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vVwmnidYM/Ap+Ir6"
Content-Disposition: inline
In-Reply-To: <20241104133954.840994-5-sjg@chromium.org>
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


--vVwmnidYM/Ap+Ir6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 06:39:48AM -0700, Simon Glass wrote:

> The package names are slightly different for arm64 and we don't seem to
> have a linux-image-kvm package. Provide a different set for arm64
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  tools/docker/Dockerfile | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index c9d794082c8..c4c3dc5a901 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -39,7 +39,12 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tool=
s/crosstool/files/bin/x86_
>  RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download=
/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
> =20
>  # Update and install things from apt now
> -RUN apt-get update && apt-get install -y \
> +RUN if [ "$TARGETPLATFORM" =3D "linux/arm64" ]; then \
> +		EXTRA_PACKAGES=3D"grub-efi-arm64-bin linux-image-generic"; \
> +	else \
> +		EXTRA_PACKAGES=3D"grub-efi-amd64-bin grub-efi-ia32-bin libc6-i386 linu=
x-image-kvm"; \
> +	fi; \

Lets try using grub-efi (dummy package that should grab the correct
architecture one) and see if linux-image-generic provides the vmlinux
file we annoyingly need for both architectures. I _think_ we can stop
explicitly listing libc6-i386, but may need to list grub-efi-ia32-bin
too as grub-efi will only grab the amd64 one.

--=20
Tom

--vVwmnidYM/Ap+Ir6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmco0nUACgkQFHw5/5Y0
tyzceQwAp34D5KojwWejdbBHdOBN57nJV1HzjqFOQwa8pynGVL317osLWiAzzcGg
X6yBaLPRyZ/0U/n709CBuj3ZhGa83a+2vtZX6Lx9/1WMCx8/ybmXwS/yMnDpOr7w
/y7d8dJQYWqs1AWDsQsR/F1stnwWGhGH/2s9pJOc7N3NamFptKs/ocbSyUYl21Zs
KvKzUgCTta9z2kA187cvD/hK2Wpu2grNtVvsdcGaJMRDlxQEhhATTXDZLwrS36+D
1sGpC5Xm+7rOhJ0j/BxIVyiSG4RIckaZxi0g47Z1T4eJLEsHRwiCKYxJHvu4y0X2
kWQdb7EKuRIBIvBGJHsd/vFoJmEKnOSjG2VUO+Py9YnUukAtLfZZ4dmL51HvJ/1B
ZVruaY/D8DhB2FhayUUZl8o+lFIckseDOrai3q8siA9n+xbhsRxO9vMx2Tw+dDo9
oD9kmJj7fQ4peDsTzzZmpCMQaVgpALaHtCP9o3zPj/T3siL5ybht+K7jwKBe6MT3
ABJROsjO
=Z9RF
-----END PGP SIGNATURE-----

--vVwmnidYM/Ap+Ir6--
