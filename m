Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E960C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 23:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1D28171B;
	Tue,  1 Apr 2025 01:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h+vAp3h3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2686F81879; Tue,  1 Apr 2025 01:03:09 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D8F80584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 01:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7272f9b4132so3639208a34.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743462184; x=1744066984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LT51KDXWBjB9NTXBWWSJjHztimhygZi3s9WK9KgHa+M=;
 b=h+vAp3h3IGHq6Z/D/dP+bxfbk3iRdf4kYQWLQIOa4giXQmexOZrKlitABhiMpQ/RP1
 RI5hQ+XI4tRaDzH/l1P1vuVkk8DTvkTQwoYH81+yM6koPK1Xsa+/4ar53gost9C1YUPz
 BiuMOhmQK6uEYJsm8QHTAzW6BUN6yn4hDFBFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743462184; x=1744066984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LT51KDXWBjB9NTXBWWSJjHztimhygZi3s9WK9KgHa+M=;
 b=cV6VYxd9wmKWzvCegckYfI9esMFlcF0FmBfL1/syw72hT+tmCMAFkQ9QDdJjDagUr9
 4W6wkyiJUbtWDmdzpmCGI3eMD1H1DlqtyV3Md1zubwd5uL8KacWjMpAGDQW0S/fUdYd4
 M8HEpoUrroKkTTm0EMJHsEnu2rcWvWntMERf9C8SMmlVJ0LGawFbvn3itN+cAWWwh6DY
 NTI72wBjE7LRq9jHOAO5ueM/Q/iSF9rknYksx2wvKYMOAUdFv0Ob/pq59vqZGp+NpVn0
 txPdEu7hytL5EpGRPCxcgMBgHfGneawYSiGpEymvFF9QX2lZb0ZhVzbdAwu3+kfzd2c/
 TH3A==
X-Gm-Message-State: AOJu0Yztt/XA3RuUIrx1qSBm2GS+xpQwy+W2xtUITDM4LEMXXc0WnZgK
 x32TaJUTFSN9n1sWBOZIxw/rhs1WK8xVmO9AVDc0W2muqh1ff42cZPPCHLASzpE=
X-Gm-Gg: ASbGnctQdqSxmVu7ADPCvpFnQfDw50Mg3te8D+pr/EAGeGpOaP+fn9bh49/vu/Jq2Ad
 2DI4FTWh9oIF21pRTpVnVEMcELoQ4LqF1mVnl++1cb+vjoUeTZoWR7AHBp9Wq2Fe/jeVmWMCzCP
 AFZCvsShtVtQ0cqkTOi8a4ACVdaBtvmvQPZ0cX6d1UckIL+YF8so1c11IVTCCENu8n8Qc97GZ2x
 5N8wmHPD0r9ZPBrVNlWKq5Clp/fqTvOKsV61Cr1Ng+mHt+LWt78cGct+t4wrFLnEYQ/V3wgKYgF
 j29uFq/j/sGOXmalW2X5bFWh5LicOhDYM5fOu0fiS6gMJcZFQd6Xaci+Kgrr0SvY+ooW6JgEiVG
 nbFTWuA==
X-Google-Smtp-Source: AGHT+IHjYMTfyXGgaRCLPI/vrEJQN+m2UTv1DT2pJRvO0+tp1zYHWcX/Eh4qCgKIWe8l+O5kO2CbyA==
X-Received: by 2002:a05:6830:2b24:b0:72b:96cc:f994 with SMTP id
 46e09a7af769-72c6377dec5mr7124079a34.5.1743462184196; 
 Mon, 31 Mar 2025 16:03:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580c8b1dsm1659781a34.28.2025.03.31.16.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 16:03:03 -0700 (PDT)
Date: Mon, 31 Mar 2025 17:03:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v5] spl: remove usage of CMD_BOOT[IZ] from image parsing
Message-ID: <20250331230301.GA30101@bill-the-cat>
References: <20250314035505.4029331-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="md99WVJSba3zNtHm"
Content-Disposition: inline
In-Reply-To: <20250314035505.4029331-1-anshuld@ti.com>
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


--md99WVJSba3zNtHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 09:25:04AM +0530, Anshul Dalal wrote:

> Using CMD_* configs from spl doesn't make logical sense. Therefore this
> patch replaces the checks for CMD_BOOT[IZ] with newly added configs
> SPL_HAS_BOOT[IZ].
>=20
> SPL_HAS_BOOTZ is enabled by default for 32-bit ARM systems and
> SPL_HAS_BOOTI is enabled by default for 64-bit ARM and RISCV. This
> ensures configs relying on CMD_BOOT[IZ] in falcon boot still work.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

OK, so this needs to be introducing some library symbol which then both
CMD_BOOTx and SPL_...something select. What we have here introduces
failure to build on some imx8 platforms such as=20
mx8mp_evk and then size growth on others such as imx28_xea.

--=20
Tom

--md99WVJSba3zNtHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfrHxoACgkQFHw5/5Y0
tyzM0Av9GoZUG31HbXmIkpf3OoAHjV26HR//uWIaWaW6BSGNlOejH86OOmTrLMmi
o8sDyP8YH/6LczsKw6Oz6DmWNMd+ZcJkndN7m/yoPWJ1z9q54OOYyXo4RJ6DXwx+
3xfWHgqd1yGpTJxeB7H1Fjvm+L7BJwZ6orSggiG4ZwK13rqyGA00bkJxhRiBtNOu
kyycPTFcXVzGV29WZf3pOEOK/UlfoQA3Rr2N/L4eLm+z7HTUTxrRj6/7KgX7CiuQ
82bIi3Qcgwe6t4kgaJt7oF5rcQqXmDrp4qh36WbHt7rayEC9N/urGNhoTqvMJEzH
27ckr48zKDlu/c0ONhYZiDb+xtQreSHohD7lLvwKejpxaOr32PRxOIq+j8prmO3b
iAX4AfYjy+wmtPGenXZRT30TpMog6VDnYbz3Ou+r+TXTjzMh2YEk3kyfKMa1JwMd
akVl/Gayo5Ljb/FNmbSLU73yyZ/h3qFdlm3kJ7o6TrQHvlJ2rnPEOhZM+jxQvaFD
idhrjV2Z
=RrPd
-----END PGP SIGNATURE-----

--md99WVJSba3zNtHm--
