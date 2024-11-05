Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89323D2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE4C891A6;
	Tue,  5 Nov 2024 17:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EPVqsOZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA8BC891B2; Tue,  5 Nov 2024 17:11:52 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 784CE88FD2
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b152a23e9aso379729085a.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730823109; x=1731427909; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yygIFtrLtWVrMklcHrZIQNrqdssfCJ+r/vZ8tcL3yXM=;
 b=EPVqsOZumiB7EzQuF1HdYaNf/ERig+kVhxGRLwHUbi37JVL7GJ7JwyuB+DSUqLxgwO
 gE85Lt6l2mQ9ZwNc5c7o+bca0u5Y4cJY7xlTFTnfV/LFyF7fWDPTGayM5zL/I6w07pfN
 IVbIKPLe2IbJeohdsBnl59elL2qRoz0kNyrWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730823109; x=1731427909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yygIFtrLtWVrMklcHrZIQNrqdssfCJ+r/vZ8tcL3yXM=;
 b=cPvSUX6AUrpVgF/Bm2tH2UCTGwI5tNnzyuQRERpMapa/u7kAAkMrSoiRFFNe+1Grkx
 o/Nk5A9+M4t9KTvatOhFRGIFQ/HJWhlDykMCxsT5td07sFoaUdN9+jhlOPXq8MmVpaJi
 IRQAWpNJ9hggUEQFYlTpQLKqt0pO0Nssfc6bm9hqCBMtFP7JY8Sb1UkgZkpKgxUNuhPd
 chngBmtT3m00jM/4ZSWrRAZTeDDB6JUIe8Ts5Bm4DXIhC2D8pkwyGACnc1FxkxiWf3Fs
 JyTOkv7w4D3pxY4En4XHGqDvovMw4YqZ3EdmTfqW8TKmQUbIEGUfL4wEwPxoA9H5ghGX
 Qe8g==
X-Gm-Message-State: AOJu0Yx9cAU5RmIREbsuiWPbmHI55fK+2KzoJGenQE6uN+xNPH+RPEuc
 NX/ogV7aYZBj1JSIJ+3Y7sgcfDUoYdI9ujYZc8q8zmG8ijjF3jvKlyVkOSGnHyvQ8T4czTybiTn
 7
X-Google-Smtp-Source: AGHT+IFN0gAemvOq3k8ESz+uRp9GNJXqCBRmbxGNX+Ut5oNVoa6x825/d9K40aeR7nDFmuDTYDzXZg==
X-Received: by 2002:a05:620a:4686:b0:7b1:1b47:213c with SMTP id
 af79cd13be357-7b193ee1bbemr5286878385a.10.1730823109269; 
 Tue, 05 Nov 2024 08:11:49 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a0c1a6sm537278785a.62.2024.11.05.08.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:11:48 -0800 (PST)
Date: Tue, 5 Nov 2024 10:11:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 4/9] docker: Adjust packages for arm64
Message-ID: <20241105161145.GJ3600562@bill-the-cat>
References: <20241105160738.3795497-1-sjg@chromium.org>
 <20241105160738.3795497-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5Z6l8GuAmazqunix"
Content-Disposition: inline
In-Reply-To: <20241105160738.3795497-5-sjg@chromium.org>
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


--5Z6l8GuAmazqunix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 09:07:33AM -0700, Simon Glass wrote:
> The package names are slightly different for arm64 and we don't seem to
> have a linux-image-kvm package. Provide a different set for arm64
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Swap order so that amd64 is the exception
>=20
>  tools/docker/Dockerfile | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 540718df062..84661b036c6 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -44,7 +44,12 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tool=
s/crosstool/files/bin/x86_
>  RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download=
/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz

Oh no, here's a big problem ^^^^^
You didn't switch to downloading arm64 toolchains, no wonder everything
else blows up.

>  # Update and install things from apt now
> -RUN apt-get update && apt-get install -y \
> +RUN if [ "$TARGETPLATFORM" =3D "linux/amd64" ]; then \
> +		EXTRA_PACKAGES=3D"grub-efi-amd64-bin grub-efi-ia32-bin libc6-i386 linu=
x-image-kvm"; \
> +	else \
> +		EXTRA_PACKAGES=3D"grub-efi linux-image-generic"; \
> +	fi; \

Again, grub-efi should be used for everyone and linux/amd64 adds
grub-efi-ia32-bin. And linux-image-generic should work for everyone,
too.

--=20
Tom

--5Z6l8GuAmazqunix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcqQ7YACgkQFHw5/5Y0
tyytlgv/UIz7e6ryhUNybgmt4StXrCYU9wvTiKBZ7PA28CIL1xEgZdhGpMlHDDMP
1LGRZrsdcI7l9r+iSAu56mfmlEj6mOBNHv7Emd91V5/vo2CxzOkYlSHyOtvgMXSs
mGA8eby6MHAhep9HJTB7Z7DxnMdZpkySKlxQESyvQPP/tAhMOvzD/QOXgFnA4mXp
YJ4kk6RtLxlvv7p7GG0rAPCAI4B8aw9hUymGeL+9/wgT4PM9YHWOVvS0ZZtalf2y
/x/10XQrrFJNwl1EF/h9MXuX8uPky6+1nE+vHz7poQeuS7u3zoSJJgQrE8Zor+93
v0t0eclOLGMPaQhUcGqV9wKZM5dzGN+IcGuKS/WkYrcoPrOVjPlsJcT0zNIcz8U3
D4E5+PHzDKcAmy3Y7hccBm9cbo7qIzxemELTBB5rgjLrRxR4BipId8+jx1ZBfPCj
YI/pwDoR74evdD7MiaGRn8LnYXib6Hwl2sPNWvyhKPcGsueRpjVFIfRqH6AHEOt9
JnkbLqyu
=bdG0
-----END PGP SIGNATURE-----

--5Z6l8GuAmazqunix--
