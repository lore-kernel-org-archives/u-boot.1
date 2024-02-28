Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF771C5475B
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 23:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3930880D6;
	Thu, 29 Feb 2024 00:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bbRl8UBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07A7880BF; Thu, 29 Feb 2024 00:31:56 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB9BA880B7
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 00:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-60915328139so4144057b3.0
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 15:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709163113; x=1709767913; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IP6FjUETl4xj+9bDDvwt3azi0BhrtQBHSEDn17k0RzM=;
 b=bbRl8UBPK5mrYHlPaD3gzRUS34qEh9D9XvBkcTZ3wC80WMwagRWcb3lGLD70722EU3
 7IK+1cxrnFdE7XWTtvQRcK+D2bcE/bIed/Y/TFmK33H7GhgRTtbVNg7X2tb1nIhS1VLL
 gfINLBg2cdET19x/ySxRA85wpfAi0j8Wlokro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709163113; x=1709767913;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IP6FjUETl4xj+9bDDvwt3azi0BhrtQBHSEDn17k0RzM=;
 b=gaqTmGaHEY8LK/38I23vCuXshZ+pLgJ8ruoSxq5yXfVD9BHUwp04b5qvBWPMEmQV7/
 v8f3YU0FccvifH8eeUxuSwGVNdrg+hhXONLwANnCSZ97V4YPg8fKr3zV/IYsekSwbgzY
 e1s3tEHzK/vEjR16UX+fYtnRduoHJsI5v4IANm2qfwyzmreDxlMhdUvmwZloHm7j2Pnw
 I4M5G1vey6sEVzHF5b2FtV8tB3LW08V8Ffus/ZkV1ecDGRDA2aTHbJn5qYbBWQR/PjDG
 7McAFij3vu6ZIMuXvkLeij1Wu9dvCltrwIA+k3Gq9MY/Qro3ZQy4GYu+uJrvfJHtFi9K
 zGLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSA2jbJDYT/qTmM+OoOBW0a/opXsiKLUT6SUvfokahbXA5Tdws2VdFoGtPYZgs0r5FcVfGM3uK12z9eSP5Z9sWNAUX2Q==
X-Gm-Message-State: AOJu0Yw90ALJOqJE6DOSXTFQpj9QUHbxD6QWGv0gaBaB2pLvuJ6w+41U
 hYhFnoczzkSb2XTJFU3rhr0A0LqxVRfr1EPZO7zCSyrxPqRM+8ZxHZoViZVVw3E=
X-Google-Smtp-Source: AGHT+IF0L6rbY7KHCHDytxRAjroFtZPap44bKdhKLsUjwS0BjR7ljErDhdT5ZFY+tiINC6VBFKDQ0Q==
X-Received: by 2002:a81:5f82:0:b0:608:b193:5a3e with SMTP id
 t124-20020a815f82000000b00608b1935a3emr583216ywb.32.1709163113339; 
 Wed, 28 Feb 2024 15:31:53 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 l29-20020a81ad1d000000b006096b3f8e96sm33796ywh.63.2024.02.28.15.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 15:31:52 -0800 (PST)
Date: Wed, 28 Feb 2024 18:31:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Hari Nagalla <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v3 07/13] board: ti: introduce basic board files for the
 am62px family
Message-ID: <20240228233150.GQ3040305@bill-the-cat>
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
 <20240205-am62px-wip-rebasing-v3-7-04cbb42eaa6f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c0u/teYldOz3MUit"
Content-Disposition: inline
In-Reply-To: <20240205-am62px-wip-rebasing-v3-7-04cbb42eaa6f@ti.com>
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


--c0u/teYldOz3MUit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 03:19:13PM -0600, Bryan Brattlof wrote:

> Introduce the basic files needed to support the am62px family of SoCs
>=20
> Co-developed-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--c0u/teYldOz3MUit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXfwmYACgkQFHw5/5Y0
tywYawv/bSCVnuesLxjaueJ+C/0rFhVDxX092wbQFZ0gzOrTkTNqsbniszh909yq
xEwkJwj6XCeJcvuSmc/iyGp/k1E2imaZGcwxr/3KS3ivT7Qn00bipXolvAhNYF+c
uwwusAqndhtXund5gvosyIMS4Pme5q53jwZiXdqTDuxP8alnWnKFxxeUG1G6+dxH
8r9TXAGLCiUj3/ghzHRZKiQUV2YgavaLgmoF6vuusCpmA8PewUv9Ktu5gXqCDvGA
PuUhbQ+mU8lvMdAm1/al0yDwWTsZlfWlVebVnPefh1Z8SMOKf2UgAtwqk8wZW87e
MWAlstEZ02XF6YxrEWeRusnwMqqFIhwMMDdJEdThuKM2u1eO6tQQAGN+BBSufoMd
bM5a86wW7JkeEuKIRakozpLRvDIDhIda48GQECfEFJxabdXsv2nP2WTBieMGqLJD
4REwZPcKliK+ztbDf2C4cgGijqdIRpXWjhN3IIM0XzloRTVMAJk4GBCV8CIDCvL6
n6+CQYei
=l8bI
-----END PGP SIGNATURE-----

--c0u/teYldOz3MUit--
