Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B377C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 13:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A864481B4B;
	Mon, 21 Apr 2025 15:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gh6zc3wZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D23D81B4B; Mon, 21 Apr 2025 15:56:03 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 569CC807AE
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 15:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2c7e5f7f0e3so1035471fac.3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745243760; x=1745848560; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qH/+b8VXQ86TfhjB03W6WwQ7jGiauLdy55JaPZnaK8U=;
 b=Gh6zc3wZLYmM/V814HJSxN+TIpv1pPZ7+DxehxXE47BKo0CMWlp85U30ygqVNvihWn
 PylqdjC5FFyiNOk9ocfAO974oPLPwsjazFVCoMEAgFrQlOX9BOQtS9WT3+y/J5G8iYWl
 laJFnbiemDsgfWT6lvgOC7T/K//HsTB7XlyK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745243760; x=1745848560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qH/+b8VXQ86TfhjB03W6WwQ7jGiauLdy55JaPZnaK8U=;
 b=NpR9pS1KbI2oLnkCYx9EwUDTfKrnHFs3XoRBGdQk8lqSnCmCF/RroOHDhImbtNf8Co
 8I7+l9NVnMXoWNc/6GuY1qgr9g2pw1ibKAN6pTIxL3m5yDdRN5tJHAnrMsRMr18PvzrX
 EKDFX5BRan8w+owZNBBtOtUE7E8JNQs6U87eRp+gq/0V9Hek3uwTaF43XXFp7Azxh7Bj
 DaYqAeB/KkB6jgpTK8DT9hKIbxHgHhWAAMtwUMw3O5oBt6EMrvxUXrcgTI9Hv7M/yJXO
 T4ehyhcN5G1/b30psuYyQ5tbX07QeApUbpC4gs22pvjCAto9OceXZafLCmrXSvprELBE
 Uh+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd1AU6d77HFkLLuqBVgD63hGYN8IH3bVhaabK0mp86snC1HhjmcgE79GB260BemvwW3Ah8u3s=@lists.denx.de
X-Gm-Message-State: AOJu0YzUXMw0fh2RYOlvpQmM3p9OGW/JvENAHi8trPIvoGWMC2URVF1O
 ssqC57PxfARcNJfnRVGFX3rxhEY2Bm3ihc/zKw4pBm2GD+CiSVFsWoZn4GHmnCw=
X-Gm-Gg: ASbGncuUycLy6Pz6tGvPx6xVmhTes2XM8vT7J1pKgRzeCseevp5mIcD/XGN+aiBmryE
 Vpc9dH5DXvVSlhzzovGvmyGzOz2pfXO/uGRKvln2FgbnoY/WU9SuT5v8s17cM7ndk9PmjE1Vapn
 lp8d9rmJY2jJwVYltTfH8tJuuQ2UDsllloEVcfDBeJ9eyOIAwx+BZBB56nKe6X0M6k4zCu3VGiU
 rsWFqJA8H60s0oLYiRS0d3/Ux7q94dz+FaBSmnZVb2/Zz6MtM1eeSkwZCtZEg4JfADJlIsvYQUh
 S28n5RtTsSrGFf6TqKeRg/rLR7uMfhPD05olw3XBn7Bn+du6VDpu+ZAFvW1Z9r8+JjLqia+n5uT
 +wA==
X-Google-Smtp-Source: AGHT+IHlX+jtLKDIUoDp73X+XaSHmkl6gL4YdBLG9fux+BKl4FMF8/2kkQQYBcbGnFbUyewzmCdNpA==
X-Received: by 2002:a05:6870:2f12:b0:2c2:2e8e:2030 with SMTP id
 586e51a60fabf-2d526b8d784mr5499418fac.23.1745243760013; 
 Mon, 21 Apr 2025 06:56:00 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d5212c9671sm1933406fac.2.2025.04.21.06.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 06:55:59 -0700 (PDT)
Date: Mon, 21 Apr 2025 07:55:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [RFC v2] Dockerfile: use nasm from distfiles.macports.org
Message-ID: <20250421135557.GV5495@bill-the-cat>
References: <20250421091141.762386-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5+1qogTrBMwZOR4W"
Content-Disposition: inline
In-Reply-To: <20250421091141.762386-1-heinrich.schuchardt@canonical.com>
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


--5+1qogTrBMwZOR4W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 11:11:41AM +0200, Heinrich Schuchardt wrote:

> nasm.us is currently not available.
> Download nasm from distfiles.macports.org.
> The build script for coreboot verifies the SHA1 checksum.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	correct sed command
> ---
>  tools/docker/Dockerfile | 1 +
>  1 file changed, 1 insertion(+)

I want to give the nasm project (and also coreboot) time to sort this
problem out, but this is certainly helpful for testing out other
Dockerfile changes, thanks!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--5+1qogTrBMwZOR4W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgGTmkACgkQFHw5/5Y0
tyyMMAv/R+UiS3wRuBCa7rBe5Ckh94EOycSwEoDSsHKM77HKNtC7uB5WU9rWC+Ez
Dz453Beo7zk/En1oOHbTdCniWfr9pyQ/zgYSH20dAjM05uVTwGCVUNjSxziAE8Nr
H0u2myoX6pb7+wjmh0tc4NH6V300cBA33LLeZiApN/o2unIsYQIAGM6IF3mVF/5U
rfdRKfh1EHImwj1uViTNAWdxUMDnjhyIkkOEq540DyK+iHQZO0tvdmKSHPvdpjUc
QzkTSx4KnhWHN5ZCAYlPjvB3mi/l3F5jkKJ80e/77hs3FUk595nfZMr6naw8rqXg
avFZ854JD8hAuKhTQi8Zq+8Hfr2iBxVfF0rK9/n0jP7Z5EUNuPlYSvvt0xIz/DjU
P6p0b/dMZHNr0BDkuY5Oedr1bsL6pnDrW3I5p5b1dltQpVBOxVRjf//Pn2m9+I61
C2lZtjv23qP7yI/oN6GZfe6JdwjFlWr5H6B1dxkY2QYKiR+alfGY8FyqBauv7O2M
1nlngFtf
=j9pf
-----END PGP SIGNATURE-----

--5+1qogTrBMwZOR4W--
