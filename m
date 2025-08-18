Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477BDCA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 14:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48915801BE;
	Mon, 18 Aug 2025 16:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mpj2LSvs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E5E801DD; Mon, 18 Aug 2025 16:17:12 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D34FC80107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 16:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-74382015df5so728884a34.3
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755526627; x=1756131427; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R6Mf8qi9XYQra4OOvNZTOrB7PFEhvM5dTWaY0Ug5a98=;
 b=mpj2LSvsYDmlGXJ8je7ffYGMMxL/cSqKqJ6J7+jBJ8b4zTFIdSoT+yjICf5TIznj2q
 qJmYd2mo7fHPrUiuELNXwdrdU4qfVRpCVG2+cgHOaxZAxKvpmm1Ru/BQ94MXUmFYGXyJ
 3IkJTWsvPKS93AfFf/SBouoLYunC04kLCBbFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755526627; x=1756131427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6Mf8qi9XYQra4OOvNZTOrB7PFEhvM5dTWaY0Ug5a98=;
 b=MTOWFYN4oEQSbHzjInRBKlAbWcQ6syerimHdY+4RAVEMYcJ1KJRAT7wUuouDddFEMv
 5Wph+PyAn0Lts8zeSD/YUyULyuUnsU0rQ6MZ+T4DimOIwzI+maPHOXc1Lm3PvOWCEmGV
 dlQOfyLiXJI+31uBfU4Ot8MPzYxb75KaZ2hUO40YmU9MJ1o7yZXB5TTObws713ASUZQj
 5L7eGFqaHRuq08zvLBWnpjIWVyqf9xM2rQta3nxAQ4ZKk/7TN0otTNavtKF+KcYBS5Tg
 suQzNy0Qp/+iYi+2E5B6P6Q4w3bV6nYmNbKM6wzJUx9IoxVoMHxdk7brIibGHNG20USw
 xamg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqf5GyrV4AsiRB7fItwMtY00WQKkTYF5g4vDAxEAAAmDEk12nBsbHP/bCQP4dym4qXY1sByAU=@lists.denx.de
X-Gm-Message-State: AOJu0YwjaWHMH6TmTh6iE8/5AoSTIHEglUTpYk9N6+JmIn8qsT3A7VZl
 pBx7KzRKTVildfzx6CPI2Fw5g9uBgHuAGFEQFmASb0ajR4fuYmvzsGAaL4zgT62tyLw=
X-Gm-Gg: ASbGncveMC8VxJJuaqIn9yQZP5zpNgFHbq0MzcfkgrBa/deM794oSVZzhl9XsxREcnj
 O5XP1Lf0oXfRX1D7XlRjzyu8AAc74+/R7TLMVjOxgXdHd10oS+MWegicL26ha12M3Bbu7KLFcjD
 7r6BH8A8ZDPryCcrFD/m476zXvtrFkQDe1LA+FC2whvAOC6gqVX2moBHJhYdYkFAvBhsKb963Z4
 AMEQJyhvhkSqzDrIcidMFhBwQCc1Pkmv2tUvdJwzt87ceHj2QL8sxbDgl7wpqoKw6AawFYkgDkO
 SQxxjdb4YcVUEfMkcG9FDb3jEcsuzW3+bPZy88iWaUpvHWEFHPSxKQaCNBLcTtZQZtyCjq8etQf
 9M7F1JbCe0xFxFXnlk0sRRJAwaJBucVFV1xHtarNHBpm0ungR4eNkFyVT
X-Google-Smtp-Source: AGHT+IEsADfHgvZkc+azXSdh2VhV4LZa8FOE2YQcFS6CknXhBeBjrE18QYe23T1Scl9aF0SLhik8kA==
X-Received: by 2002:a05:6830:43a8:b0:741:a9d1:3135 with SMTP id
 46e09a7af769-7439244f671mr8913969a34.12.1755526627411; 
 Mon, 18 Aug 2025 07:17:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74391bd1ce7sm1840849a34.15.2025.08.18.07.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 07:17:06 -0700 (PDT)
Date: Mon, 18 Aug 2025 08:17:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Sascha Silbe <sascha-ml-reply-to-2025-3@silbe.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 8/8] Drop the special am335x_boneblack_vboot target
Message-ID: <20250818141704.GW124814@bill-the-cat>
References: <20240627082949.357089-1-sjg@chromium.org>
 <20240627082949.357089-9-sjg@chromium.org>
 <yh7ro6sfsbjh.fsf@twin.sascha.silbe.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GzDkNfLmo/LCIOmV"
Content-Disposition: inline
In-Reply-To: <yh7ro6sfsbjh.fsf@twin.sascha.silbe.org>
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


--GzDkNfLmo/LCIOmV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 02:20:34PM +0200, Sascha Silbe wrote:
> Hello Simon,
>=20
> Simon Glass <sjg@chromium.org> writes:
>=20
> [...]
> > Now that am335x_evm boots OK on the Beaglebone black, drop the latter
> > and update the docs to cover the change.
> [...]
> > diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
> > index d243cb16e72..cabc181460a 100644
> > --- a/configs/am335x_evm_defconfig
> > +++ b/configs/am335x_evm_defconfig
> > @@ -13,6 +13,8 @@ CONFIG_AM335X_USB0_PERIPHERAL=3Dy
> >  CONFIG_AM335X_USB1=3Dy
> >  CONFIG_SPL=3Dy
> >  CONFIG_TIMESTAMP=3Dy
> > +CONFIG_FIT_SIGNATURE=3Dy
> > +CONFIG_FIT_VERBOSE=3Dy
>=20
> Your patch drops CONFIG_LEGACY_IMAGE_FORMAT as a side effect of enabling
> CONFIG_FIT_SIGNATURE. Is that intentional?

It wasn't entirely intentional, no.

> Debian systems use "legacy" format boot scripts to boot (at least when
> using the "flash-kernel" package which is probably the most common
> configuration) so recent U-Boot versions cannot boot Debian systems on
> BeagleBone Black any more:

It's frustrating that it looks like Debian 13 is shipping with this
legacy option as the default, I assume for all 32bit ARM systems, rather
than any of the more modern options. I'll take a look at what the impact
is on adding LEGACY_IMAGE_FORMAT to the "distro boot" option so that
nothing else is missing this.

--=20
Tom

--GzDkNfLmo/LCIOmV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKM13AAKCRAr4qD1Cr/k
CvRBAQD5Eni0i2RaI8CQmysNg16dBKeAz59jSKWCMrb/nIV48gD+LT9NnjHbt6AP
rEUCIiwEKx6IPSH706bIXcox+IDH8ww=
=Fbyy
-----END PGP SIGNATURE-----

--GzDkNfLmo/LCIOmV--
