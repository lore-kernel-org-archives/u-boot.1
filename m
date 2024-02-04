Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB591C48286
	for <u-boot@archiver.kernel.org>; Sun,  4 Feb 2024 19:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48CDB87C2B;
	Sun,  4 Feb 2024 20:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I4TWxoGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D5087C2B; Sun,  4 Feb 2024 20:28:32 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0116A87B77
 for <u-boot@lists.denx.de>; Sun,  4 Feb 2024 20:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-603fd31f5c2so37048167b3.0
 for <u-boot@lists.denx.de>; Sun, 04 Feb 2024 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707074908; x=1707679708; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2J4/ThAa2O4b2lVmVjmfdQ6BsWV1zyfn74QBlFlkvhs=;
 b=I4TWxoGz7w92b+nn6ojDqUrDaH48BNaayUfShFapG0Z3g0P6M0NSc99G10m2LevQnJ
 /y2ZqrSJ+eZjYjw97xpNI+F8TxjdVJSgbFuGLfFP/rsYVhHxy99LGgUq+VrKFPfN2ly3
 AQDzi4n/iExcynRVYGlRYrNU9NXmY7kWDSvLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707074908; x=1707679708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2J4/ThAa2O4b2lVmVjmfdQ6BsWV1zyfn74QBlFlkvhs=;
 b=Sne0jpl23CT3lo5iXIfVAru/kTGJQPpuvt+B7PB1t6rRb2JajjQilNu3W1hdNvSL9J
 jB+uwJEkpfVWp1bj+/pkxZhoXGXX8zU7d4gRknHxKFA3o2S87xYc/txu4ryftEfOyQi4
 uQTuSuIUaWhUEnErZvvIYJwTanSCyi3QjxrE8XnDEFOo3vMi5AIgEchvRnNWfzvZqzOH
 efRnYyw2SXFWiFdyy4NNapt6Q4lcSoxzorTC813uYacXVtCXhWHSK1vjIQZ93VxLLi9s
 2aE7XBV+b9XOA6Pax6T8S7rFXwX+LfweHikViNI+L6y3R7iOrSDT+hRxK/P5n1cnaRKe
 zY+Q==
X-Gm-Message-State: AOJu0Yx0tC77OQElRJq4MYCD9RO9AttRz4rC4RaqzZhthPdEH+wouxuv
 cv0bBrAySoExqauZ8kIBFX+p7G0ZrLupbh9n02b2hJojS+CiaY/UgaPHkT8zxVQ=
X-Google-Smtp-Source: AGHT+IFtX7TycgzneIOe9NS5OodXHV8EKRUEpAFhAiw2VQ2jZ+KG+UwSdSRF0jwsQg8mgvaIbNoU7g==
X-Received: by 2002:a05:690c:3388:b0:5ff:6c59:624e with SMTP id
 fl8-20020a05690c338800b005ff6c59624emr3041509ywb.2.1707074908655; 
 Sun, 04 Feb 2024 11:28:28 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUp8GdFqsNaQR2QtMGZfXIqd+Nahi59xCYa22Uh7eYcZXtu6Z6FoiwX7HXidYEAOklgmFzqHKBQdcfjCPzur5cHtBPMbu/NGjt8kjQAGP+2gtPVrYPyeAgFGYTbeJ4oX5eB
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 fu10-20020a05690c368a00b005ffa141d9f4sm1554895ywb.18.2024.02.04.11.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 11:28:28 -0800 (PST)
Date: Sun, 4 Feb 2024 14:28:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] docker: build QEMU v8.2.1
Message-ID: <20240204192826.GH1152441@bill-the-cat>
References: <20240204191357.178510-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D6Wfr9VPX0yXSReM"
Content-Disposition: inline
In-Reply-To: <20240204191357.178510-1-heinrich.schuchardt@canonical.com>
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


--D6Wfr9VPX0yXSReM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 04, 2024 at 08:13:57PM +0100, Heinrich Schuchardt wrote:

> Upgrade the used QEMU to v8.2.1. This avoids patching the source.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/docker/Dockerfile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 6122776bc6..7df68d9c9c 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -178,12 +178,10 @@ RUN git clone git://git.savannah.gnu.org/grub.git /=
tmp/grub && \
> =20
>  RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
>  	cd /tmp/qemu && \
> -	git checkout v8.2.0 && \
> +	git checkout v8.2.1 && \
>  	# config user.name and user.email to make 'git am' happy
>  	git config user.name u-boot && \
>  	git config user.email u-boot@denx.de && \
> -	git format-patch 0c7ffc977195~..0c7ffc977195 && \
> -	git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
>  	./configure --prefix=3D/opt/qemu --target-list=3D"aarch64-softmmu,arm-s=
oftmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softm=
mu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x=
86_64-softmmu,xtensa-softmmu" && \
>  	make -j$(nproc) all install && \
>  	rm -rf /tmp/qemu

Is there anything else here we're gaining of note? It's not a problem to
cherry-pick out commits (and something we need from time to time
anyhow).

--=20
Tom

--D6Wfr9VPX0yXSReM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW/5VYACgkQFHw5/5Y0
tyxVeAv+LVzZESq+HIuHXr9lb1F/aUBllT2iC8qnLzYXtPpNcDxJc+LvcW2JiLjn
vT7Y6nk7bb5h1RXZ8olZhytxQE4N06S/BOWnrFHVoVABJIPtfYzIIw4NBc/yuloo
o53FElLoD+SEB6kHJzO1lztKoM4/WZQDMZOyMSGTGyl3ay27EUTZ7u+WPBCBGr2b
uMc5r7uPpltJrtdGfHIS4khEKmyTSM6pA6gW8yNzUwoGCcI8EiYFT+YzJ7Hk6MtF
Ww8E5i0hSOf4osf02QI3LmBHlSzGUNzW2k5s7IVnUs2DGWdxOKhJcnVIHbdxiJso
kNrw46SU1QsJCD6lPBAate2TGMtbERyEtVvyA18BuNi5tjihRvCu9k00T0Opcs+P
nQ37g53/7qN1zp7yMwdEo2CuA+vXe8Kd8bxrNEzeivr/t89IcgPB4gDWHK76EcVi
VTSbhrwSYBpF33R5+3Nd8nNwiVf6BY8ZsxVUx8zcaZHNGNVv6e5XbhgTOygJGu/K
o/8sX0We
=I1ns
-----END PGP SIGNATURE-----

--D6Wfr9VPX0yXSReM--
