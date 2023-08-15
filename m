Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF73CC0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C7CC86995;
	Tue, 15 Aug 2023 18:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M9ngJF1B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B8E869B8; Tue, 15 Aug 2023 18:59:21 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A8B86985
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3a5ad44dc5aso4771239b6e.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692118757; x=1692723557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S8rQd+jV/RlsCeE0G4nDr6P5Kgzd+s1CbPZKaMoPjd4=;
 b=M9ngJF1BUFczI4TlIoCr/iFypOXdl0ly28i4z0SPkbUWtwLM87lKOJ0YERMwhNzwj6
 ZFrh5dl1LJAV2AZ/dMswaVkZaibkwPsj88O8/VN8pg1ZxHuND2Ir7HFZ6oSif3rDZzy+
 ZN/tc0dz7mqhFBDeZat+s8REVtrfKY+4k4A4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692118757; x=1692723557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8rQd+jV/RlsCeE0G4nDr6P5Kgzd+s1CbPZKaMoPjd4=;
 b=YqEeE6MkJM2+QdZaLRjnbbPFpB85IjJcsr0LqK8pPAKqbQrUlQd8j6hGzBpreSqDBT
 Wb/6Hzjx+4E5XjpcTUi+IH1FQpnBp5v6X8sULWCIerVWHSQ4cnauzHCR3sggnmckn+58
 2c86TFwtbzh7zIqx7gg0uBQ2Jxbt6i8yA4nUGIVQdkAthcod23rOpfbBHxuZA6taWIrC
 rFGmuOrA3/vjKpAS0pFlKzjXnmRRJDEGkqaDYU75DPI65KlafJTAySwjeW16tLBHnUpD
 0VXqzy6B+xQUe7O+S3Ea1UX1cSERS3lD4Wkj9tNaMSis5f4eK3Kxz67BPbD2Q1wWb+iE
 DRIg==
X-Gm-Message-State: AOJu0Yyp6r7A4AAyNvjMPpjM5J4uYaAr9z94yD4e6KMdkw8ZW4zjhVTg
 99ZmplOeMlO4ZqzBgiG/lV9Z9g==
X-Google-Smtp-Source: AGHT+IF1S2IzWEYE3EkkXi+yxVi50uxyYOpXWbAhraN+qp0qqdvHCdSYUofAsjzZ7LrfhM8FX3k8xA==
X-Received: by 2002:a05:6358:881e:b0:130:5951:b268 with SMTP id
 hv30-20020a056358881e00b001305951b268mr9062974rwb.31.1692118756853; 
 Tue, 15 Aug 2023 09:59:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 a123-20020a0dd881000000b00570589c5aedsm3497579ywe.7.2023.08.15.09.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 09:59:16 -0700 (PDT)
Date: Tue, 15 Aug 2023 12:59:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Sam Edwards <cfsworks@gmail.com>
Subject: Re: Please pull u-boot-i2c
Message-ID: <20230815165914.GZ3630934@bill-the-cat>
References: <e99b4be6-ceca-8275-5826-3fb27630f030@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bflTyQf04z8YLJ2Y"
Content-Disposition: inline
In-Reply-To: <e99b4be6-ceca-8275-5826-3fb27630f030@denx.de>
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


--bflTyQf04z8YLJ2Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 09:53:55AM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull from u-boot-i2c:
>=20
> The following changes since commit 832148f675e427060be074c276956962fa9b5c=
b6:
>=20
>   Merge tag 'u-boot-rockchip-20230814' of https://source.denx.de/u-boot/c=
ustodians/u-boot-rockchip
> (2023-08-14 09:11:09 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-update=
s-for-v2023.10-rc3
>=20
> for you to fetch changes up to 250454c59b1b056d47cbb0c6d8d09a68416c9776:
>=20
>   i2c: mvtwsi: reset controller if stuck in "bus error" state (2023-08-15=
 06:52:04 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--bflTyQf04z8YLJ2Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbrt8ACgkQFHw5/5Y0
tyyWbwv/S8A61+s6QypEZCklnGXv88A52F6kzbU9DSmBtPYSH3nfweNiwymV0rfS
0ILrRtqqvvrHv8SlwHmDMtLUsXyqp/p+yYKo0AZHb1M1bJFWm5oxJACXcdzGvsIc
GdClleaMw0vUgFDELbSo6JT9W7H/aIRk4bL+ip2ANb9DT+3fdctuJ/hk0VS86mWB
aeTuWs4BAHtAIyazeip5+pQCMjAbbx9SFa5YOV2OqthdHE3HLqOW+vZj8uzIpLIr
WpmP/uCIQwoKfffIQMHdHHPEH1u/WFhyPNqzzUOsMxUCHJPRvNDPMWAvFXF02tvt
kGpO1+L0x6fZPTdv+CdVC+7cwuCHL6H9HU3MsvVi7tIONPEuQm02d8ptc2enroIe
MVILPr210WtZLQ4fZO1j9uVfeJulrv8JsZcbt6TzTgb7yS230n1hUT6OkGc8suR2
faHZPLDEeFtIVR37qpgiXT73iSSAf7iruo/KllqnviGeKvjFzJXP2G74bPCQf9GD
lwSykfcy
=nACO
-----END PGP SIGNATURE-----

--bflTyQf04z8YLJ2Y--
