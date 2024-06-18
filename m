Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AEDC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 16:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489458819D;
	Tue, 18 Jun 2024 18:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="as+0Qdhi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DC54880F5; Tue, 18 Jun 2024 18:22:32 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B3D8819D
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 18:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6fa11ac8695so3153907a34.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718727748; x=1719332548; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sGcH8EZfHe5R86gHm5OF4CiCoKW7VsVxIy3dXMrZpLE=;
 b=as+0Qdhi/t6XppTeDbJHg3eq4lWz8YDVPGQM7My/SkNTAT342PVLKRFJXTNrmroLU5
 AS0ce1X1uf2/l4gfhSuFkWLgbD61MiAUXc90cp/PfcgJ4O/26cHKz0T/D3buXGiNbQSN
 tMudBYwDj+ZkKLGSfdKW0eHQV+aM/CFHgqtMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718727748; x=1719332548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sGcH8EZfHe5R86gHm5OF4CiCoKW7VsVxIy3dXMrZpLE=;
 b=w4yy2o6DzKnKsYUMLocWOJfk+LJj4vwSGwn3awf6qoT6NVP5+EdtfMqJs1U+rtAOMj
 FugpF8/hjfubkm7F+9uxizpaT+E+L0DXfPEMcQ9taZWwmMKuSZpyVNK2r2COVo5Ai641
 kuWFclhZyItM8bZ7l6Wt2qFhrj0s6HohKMG+AtL9Mw1R3smv/9uEu98kv3ADjREX70o8
 qJcn6Ll985FRkNEeINy2mAgplkrXUZ1n5HLoVa/UcrXkx9G8mFue3eTewTE85RIitnVd
 j9WovE6mcuqNLdP7f65ZD4mFEqidGMM/LxSVllHuL+joXAg2SHHQDHk/hgGjKGrds3Ay
 V2EQ==
X-Gm-Message-State: AOJu0YzxBKTXf8HNekXOCQO7aChJxOsblj9qcRRhI3J6GwCw765njhcm
 oVBorQScXTdGo2dnFmIweS+97Gblc0QK7VCL3nZtL2uw5g7YlkjmPft4DTa6jEg=
X-Google-Smtp-Source: AGHT+IFpGymr07JfqEeMiXRiUEPBUB0m7EJz1R05ppLdSurluM/Fx1TlwJ5gkrHv1qkUmPw+kwngpQ==
X-Received: by 2002:a9d:7a55:0:b0:6f9:6e0d:dfca with SMTP id
 46e09a7af769-70073b36ddcmr234548a34.14.1718727747816; 
 Tue, 18 Jun 2024 09:22:27 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fbed9e8154sm1535100a34.21.2024.06.18.09.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 09:22:27 -0700 (PDT)
Date: Tue, 18 Jun 2024 10:22:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>, Stefan Roese <sr@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: Re: [PATCH v4 01/14] flash: prefix error codes with FL_
Message-ID: <20240618162224.GS68077@bill-the-cat>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <a8dc4451931828f757905d363b6d1bf368b829d5.1718638104.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XbiW2EWhylRlfwYG"
Content-Disposition: inline
In-Reply-To: <a8dc4451931828f757905d363b6d1bf368b829d5.1718638104.git.jerome.forissier@linaro.org>
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


--XbiW2EWhylRlfwYG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 05:32:53PM +0200, Jerome Forissier wrote:

> Prefix the flash status codes (ERR_*) with FL_ in order to avoid clashes
> with third-party libraries. Case in point: including the lwIP library
> header file <lwip/err.h> which defines err_enum_t as an enum with values
> being ERR_*.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--XbiW2EWhylRlfwYG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZxtD0ACgkQFHw5/5Y0
tyw/LQv9GkQYfuHYCf4bPXZ7NsXSTzTyDVoHh0hp0Fy90p8Ke/lWuADsfEN3O+3e
Bh4bLB9nowTPYhQjoF6wvJgk2Dur2Q24F6OeqBiJF90MzW2UElGUtZBtTVBReyCX
H6YxkdMV6MIgp5SXDoVt0m9qddNvZHi/KqvbjfDWNTDQLDqzJpckqPKj1EwwpCLQ
p2QIXjVw6AlNcKmuck6BGpXUByfeDPUomMYKz4W4Y/rdepLejND6B8TsdDo0zlej
Kw3Hebge67Ze2eR7M9Y9uEasH0OmDatzS9C648PJfKrmRAbHSdDNXMyCexVg/V46
dWz9zfZltrWF+pNcF882qUgM9bcmreRP2rDXmOgwWycnpddCoGkBHA6BKMfaijkB
YrTFfZYVDDLyeAL8kpsUr2+gseTXHHO5NPSfEOE5JzD0TrdxnSWY6QOpHWWELsF7
9K/6BjYcFp2NBOS4fNKNcZ1h7HrfQ+WXAYBTXSHX4eI7IPGiMsX0ZcIQiH+YzRpU
OyF5Mc3D
=aQE5
-----END PGP SIGNATURE-----

--XbiW2EWhylRlfwYG--
