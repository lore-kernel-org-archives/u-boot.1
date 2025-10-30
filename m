Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FACCCF9EE
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 00:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6ED5832AD;
	Thu, 30 Oct 2025 01:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EvPySs3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EB2832BC; Thu, 30 Oct 2025 01:31:45 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3103B800B6
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 01:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-443ac891210so275632b6e.1
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 17:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761784301; x=1762389101; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d8iNDHaxotnrBoe2GOccTJYhbB4nSPpFS3FlIzjkT0M=;
 b=EvPySs3f9laGq60tBjr1LR/Mmrw+T/zi4YCMx0zsS124Qa8p5g66Tq0xz3pcixjq3j
 E/xZ/WzmpTNiC3ndIFQatO6MwgXgTDR4KdFHh4SQE/c1IoL1oG/bfjYGEPO6uDgUeEDj
 3h2IF/+WOfmHpQS6Yv6qDn25gJXfebwPLCnTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761784301; x=1762389101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8iNDHaxotnrBoe2GOccTJYhbB4nSPpFS3FlIzjkT0M=;
 b=MR0Zz23TOa8/AmpUMtdGL6vi9j2GLdn656xLlFNRK5fVuxkt1adR2J0HEqGh8fTNqi
 mhvRM6o3YoZXoOteOCmc/SFDjlUodXrTkepNz3r11qmCpP17kcJ2IUSctSqy2sYmmCUE
 PNMdElYe7/ZR4/yE3cGKLhmCVhHdknNLjH0lekX/GhLp5WHEefQCiLQce8uV0hC4G6yQ
 xiBe8M6++3QZhtX6XTkk/Wpt3WeL9I0rPz7wNwpZUOfFYd4gvIWvb64g1Vji0vo2ZKmX
 9xa2Qf29RBpNY92bIhvSFY34CuvMLpbpcSBCgwA9wppcnyS8F56XESAvjqrxqGhbIWTP
 tWDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Xu4uUzhictRqDyQa5GdzAr7pELn47oR7dtIaOH2LZ4srOpYRcL2YNTseBdroRte7kdsvg7Y=@lists.denx.de
X-Gm-Message-State: AOJu0Ywb+5RfLBziCmyf7p4cs5U4KePX3+YuyA0di611tZeMtqBpu7DJ
 YXqBdhGUdvOlqGet6tXtDR3VXnX81g42cFii2m0X7LBahqK10zNU/P40qCBAsHSTGXM=
X-Gm-Gg: ASbGncuEsBzEGC9PXeFG64F4B13YICeTBBWYUxG6I3CcVJ+zMgzWSaUe/BQ8p234zvJ
 Hw7OyhiyGvWa0aN0JObrPs9su5Fcy9606C9/TIireN0+60QPIajxkEnKRzNjnvjTMCUoJU0TaOz
 LcyohNwEY6muRBHMpAKynmOBORadvcNLsiL8VuUrZYMXFpeSWveZsw7pygkmCII6wdaYEry1iGM
 L0aSc19p5ylQV1VRIJmBwXSByVZrp3ETdCd9D4U1GgAx8wGruxk95Pt7C1rGg8+xrAp7hEky8rd
 jR1lbTC1/ZILWd3ymBqOwmLn60ARmmwxnBHHp7nAEq8OESH1dC52nvwOZFsJMEXIa/mN1vvGPh/
 QszxDBPY1Pgimnw3FTwjXlFubU8esjgw1ChwF12ZSmaiH03RcEBGaBlaq9PpD8ph7F1muzDIjN2
 m+ydz6/FXryk3XXARdmOPwWvBvSqEmHuxjapKCkes=
X-Google-Smtp-Source: AGHT+IFpOFbB8CIqnJUsjdVFxgKnUh+B1JpYXPXhGjBCn9Y9AkNY9yH3tIPAfSYOWERM0sfnRzR+Aw==
X-Received: by 2002:a05:6808:4f67:b0:44d:bc9e:3163 with SMTP id
 5614622812f47-44f7a3d0757mr2523877b6e.7.1761784300756; 
 Wed, 29 Oct 2025 17:31:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3ec0e9esm3933277b6e.23.2025.10.29.17.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 17:31:39 -0700 (PDT)
Date: Wed, 29 Oct 2025 18:31:36 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v4 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-ID: <20251030003136.GA2558427@bill-the-cat>
References: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0D81du+ptnYNe4xu"
Content-Disposition: inline
In-Reply-To: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
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


--0D81du+ptnYNe4xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 05:20:11PM +0200, Kory Maincent (TI.com) wrote:

> This series converts the extension board framework to use UCLASS as
> requested by Simon Glass, then adds extension support to pxe_utils
> and bootmeth_efi (not tested) to enable extension boards devicetree load
> in the standard boot process.
>=20
> I can't test the imx8 extension scan enabled by the
> imx8mm-cl-iot-gate_defconfig as I don't have this board.
> I also can't test the efi bootmeth change as I don't have such board.

This has fail to build problems on:
sandbox_spl sandbox_noinst sandbox_vpl

Seems otherwise fine however, size growth on platforms not utilizing
this looks good. It's a big big when you need it, but it's main U-Boot
and I think in the end, something we can live with.

--=20
Tom

--0D81du+ptnYNe4xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQKx5AAKCRAr4qD1Cr/k
CnVrAQCtJdrGHyEMbO3COhZIgTWa12oRmQoSuPZG0pS8abWCPAEA/0I+HS0+Z7Yw
AivSa86qzQEcxNO7Rs5D0RmDK7bFmQM=
=h9nd
-----END PGP SIGNATURE-----

--0D81du+ptnYNe4xu--
