Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDE8C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 15:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97FF587D58;
	Tue, 13 Feb 2024 16:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hqOM/wyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7394287D66; Tue, 13 Feb 2024 16:32:06 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1070086A26
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 16:32:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6077a99bbf1so10544347b3.1
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 07:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707838319; x=1708443119; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lCTqFdu0vmkeSpUddhPxegTA+/k3UaVO1FtRzVEFMSE=;
 b=hqOM/wyS11onu0IaO9OAgdUVnjn/aiNmrabotM4XpUBVCxXkNYoenI+2AIUs3zKaL0
 +eKBe5FZSIJ4m0wCmfvs05AY2A1gc2jHNuIA/R8TL9FSUMRweSFTPIgzlHZXhGYvS30f
 qKh5urHkqYgVup/CgquNZFMphhcZL7S1btOi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707838319; x=1708443119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCTqFdu0vmkeSpUddhPxegTA+/k3UaVO1FtRzVEFMSE=;
 b=dW4gMZm9VPqx+85lHnPLZXndhoVy1N2ur5zFPvEjyiTQKvTMvI7A23mqoA++AvYJ+F
 4v7eqvAxQWa2tlwXinVANNAJp2QUCH+m2N9rHkESVlniQlY8jT5cLOV1v2YYzmzgrepV
 yV+B8QhQ81/O+KJvJo2wa5kFPr5KOzrl+ECXXOe6BLFIkSIqkUdhLLXFRQbaFpqC9FfS
 TaZz+9QBXD8eTFAHIq7N29rm3MVovFWrl6TrBxZ3jE4FK1IRcwbcYcPIDgwJZa+80oEu
 JPFYJkIqEejIF96538qtPVJZukI8tIp64QzLOAIndfND8RAdZvpam0ctTS8xtPHp8QEU
 SqNQ==
X-Gm-Message-State: AOJu0YyqsF6FoGJnJRHygzM5x0k4NEu0icUKv5uWBA24tXpFXNiSjFW4
 pKQXWYOvqyIpuO7GlReXMuI63n6c8ZsqF2L7loCfnYR4tkq2CyIeXEDQVROUPiBwlUNdc9AAPMR
 t
X-Google-Smtp-Source: AGHT+IHZ6a6xU5lSMixdN2rDQVDISOWRr3eJiCyIhCCIyqxrZ3erOqVxQpeyqgG1+mNTY6ZVMx5VmQ==
X-Received: by 2002:a0d:eb8e:0:b0:604:55e9:fb35 with SMTP id
 u136-20020a0deb8e000000b0060455e9fb35mr2115035ywe.7.1707838319308; 
 Tue, 13 Feb 2024 07:31:59 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 y5-20020a818805000000b006040f198d3esm1749980ywf.142.2024.02.13.07.31.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:31:57 -0800 (PST)
Date: Tue, 13 Feb 2024 10:31:31 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] Dockerfile: Build coreboot from source
Message-ID: <20240213153131.GS3040305@bill-the-cat>
References: <20240213143928.91443-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7/p5iy2fW/N+wp71"
Content-Disposition: inline
In-Reply-To: <20240213143928.91443-1-trini@konsulko.com>
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


--7/p5iy2fW/N+wp71
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 09:39:26AM -0500, Tom Rini wrote:
> To make CI runs rely less on external servers, build a coreboot release
> from source and populate /opt/coreboot with the output.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  tools/docker/Dockerfile | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 6122776bc64d..3d044657406e 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -231,6 +231,17 @@ RUN mkdir /tmp/trace && \
>      sudo make install && \
>      rm -rf /tmp/trace
> =20
> +# Build coreboot
> +RUN wget -O - https://coreboot.org/releases/coreboot-4.22.01.tar.xz | ta=
r -C /tmp -xJ && \
> +    cd /tmp/coreboot-4.22.01 && \
> +    make crossgcc-i386 CPUS=3D$(nproc) && \
> +    make -C payloads/coreinfo olddefconfig && \
> +    make -C payloads/coreinfo && \
> +    make olddefconfig && \
> +    make -j $(nproc) && \
> +    sudo mkdir /opt/coreboot && \
> +    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/

And I forgot an "rm -rf /tmp/coreboot-4.22.01" at the end here which
I'll add while merging if there's no further comments.

--=20
Tom

--7/p5iy2fW/N+wp71
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXLi0kACgkQFHw5/5Y0
tyxTJAv+Ma58PQrDZH5YgZACOEpYbnJznDkKZVp7kc4SMF53nXLp55ShOETFp0vb
UH8SzffEd1o2Ke4jDtemkBaYGeK9v8XrBSbnxZ62v0aFsGypz6vwnOUEVprP8SGO
wueHxnQLDduhHgpOno29aF4VE7EcHv2Fsx3moJx1XxX9cNal14JZYyyeqZaj7KUe
pPT+1mYiyYcdRzshQaRKEQETdgOPFDOQeFYj4g9Ib/SKWVgANn+EtRiGTYgpBqii
6aEhTXphNYDHzrLhFqcZxW4nGHMejUPtHP2Gi6DRVVU5I3N1Ody4NSHZF5iqSogf
ygNa82RZEAnboaM8IaqHJZ8p/waoo0f5t3j/LWr2pD/E0OqIe3Ye0eIX8Htt+uep
OYFBaEYlbW9v1yKSyG6YDgo+Fmy3tuRC3HVeyAjBiJJd1DryNZeX55oN5GdTZTwJ
/+z/yPKUhYNzsWt4sPAONv1ak4RBWJs7uOOuwN1xiz+dJoFNMCPkveheP3EnrBr3
Ow7d+RGl
=f0ru
-----END PGP SIGNATURE-----

--7/p5iy2fW/N+wp71--
