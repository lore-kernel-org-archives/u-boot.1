Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224EBC10F1A
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 01:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9983788131;
	Fri, 10 May 2024 03:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ua1LZe7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D76B688131; Fri, 10 May 2024 03:10:19 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B12880E5
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 03:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-792bae4137bso139457485a.3
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 18:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715303416; x=1715908216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DRnWUD4U+6aLYN6gBcEODLgz1JiZYuu6KhpXvimUfno=;
 b=ua1LZe7oXOB4VO9myMcB1O6R7JiYS3rQ4vUFKQeqJplFfAKC6+Jekq/kBcKAVSeUNP
 C8e1uTUt145XZhUf9odIIGO2c34oT03FDStlpX93rUXpuR08DmSXM8BWgVmqjmvhCtwR
 17bLN81p5ugrybnvu2x9SNWDdpFRC1MWOeG3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715303416; x=1715908216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRnWUD4U+6aLYN6gBcEODLgz1JiZYuu6KhpXvimUfno=;
 b=Zn1WSMyUxA4egLcUlEuB1JUtArxj/u67RDHCSThYR7f0EqO4pbD5HZ2Ow9Q7p+Mm3n
 Bjm0H6f1SD6zVw89oBPgcaHkNIjxqQTX9K02pLa1CZgWGeQKyDBsJNoTJLHTbewMdtj8
 AJPYNfzydaTM7TbSOIgBS+EwNQgkrM14NfENimy6aMtT+/hpt/ET4P52g9HfA/BEUEOe
 jMTNORv0FfZUzqY58pUijj6p/ObCjnd5vDRDIzboaa7l3dJBX23HB7jrRt0lc5wqgmhy
 N6lh4Br+Kbk+tjA8uXSTlJdCng+nO98/V6rNuZZLDMy+78KT1X621dYziUT7SMYzgQef
 f6XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWekkFw73FR3Fq/em56NeRdwkihyZspGBl0iQDf3sC1YkppteRhHO+tyY2tbd8pDhlk/t1KWkn72mp0GeuwZxtRsePMYw==
X-Gm-Message-State: AOJu0YyO5Owt3xhPJ74zHBQQbxdGONmZKvMPtG44vuhAx3N4MbGPacj0
 Q1TrKMNjbtIimkGSYo4WTGbjEQEgo3LduOtb2CwGVVU9JUupvoOCJvwG67ph/fw=
X-Google-Smtp-Source: AGHT+IEt339b14eplWiRjRk5WlMHqwB6pwXBCUrR4apdkEZtHg2BC+KidCC2d7Lkuz66faVKOLq5LQ==
X-Received: by 2002:a05:6214:5d05:b0:69b:2523:fcd3 with SMTP id
 6a1803df08f44-6a16825d79dmr12981986d6.60.1715303416531; 
 Thu, 09 May 2024 18:10:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194c88sm12234236d6.65.2024.05.09.18.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 18:10:16 -0700 (PDT)
Date: Thu, 9 May 2024 19:10:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] sysreset: psci: drop reliance on SPL support
Message-ID: <20240510011013.GQ2568172@bill-the-cat>
References: <20240509230600.11306-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VBhrGy92JENGVl4C"
Content-Disposition: inline
In-Reply-To: <20240509230600.11306-1-andre.przywara@arm.com>
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


--VBhrGy92JENGVl4C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:06:00AM +0100, Andre Przywara wrote:

> At the moment enabling CONFIG_SYSRESET_PSCI *selects* SPL_ARM_PSCI_FW,
> even though this is a platform design property, so nothing any driver
> should enforce. Some platforms load the PSCI runtime (TF-A) only in the
> SPL, so PSCI is naturally not available during SPL runtime.
>=20
> Spit CONFIG_SYSRESET_PSCI up into an SPL and a U-Boot proper version,
> and let the former *depend* on SPL_ARM_PSCI_FW.
>=20
> This allows to enable CONFIG_SYSRESET_PSCI on platforms without SPL PSCI
> support.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--VBhrGy92JENGVl4C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY9c/IACgkQFHw5/5Y0
tyxxKAwAgP8fPoYjZsy7T0vPNlJjwq2a/bz+kIJpCueW2JWeImaBPicboJfZMhWU
X35QI1cLD9B+R5wqPrQuQziCeXJdd7ns6Sj6Yyr0Ia2FklktaMZcQR2JEKi8TCdD
GAQLpWI8jk9PuxSJig0eQEgV/OuSZM9dJzJ2mjXy9hmxMYlGIx7OEAvMAT+eL8nl
8lonNudsEbetaG9u64qujn+YOycZI2wNNrE9U0E/8DyVWOX0RcBw9+jVWBzw1A0+
pWvgGcl0yhSRNpSrvN8UPSGVWBNzd9ly1JzUAv4MTuSkkfVaNUShoOAbePKkgN9H
l7Mgu8z84pNaAP3PM2JE/LtRsOlIz1sawiLgS0UuLLuTLsFFUWpQIm7y4o72K/+2
bGwak0p3utWwCm9pUeecWyg1SeRSCk6HOIpivN7m6MoWRItbMf/k565RSXH1a8k9
3qkDwzBMWGyGzf1tRRft1r3Ei0dSILE8CrcR2trcCCyhXBF96zVEqw68Gmf4ONwL
ZlY3gKFg
=2eFU
-----END PGP SIGNATURE-----

--VBhrGy92JENGVl4C--
