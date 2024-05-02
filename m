Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1278FC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 17:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4317D882C9;
	Thu,  2 May 2024 19:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dJzY/Cmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687498830F; Thu,  2 May 2024 19:50:32 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 432FC882CB
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 19:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-22ed075a629so3338827fac.3
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714672229; x=1715277029; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dlhkT8J4DSi99CdUIomXiK1nZ+fwXJ7RdhpX1jWAuRM=;
 b=dJzY/CmtZ2SqXfLN0ypH4RumplqpHRv1BW8R/CbrGdm1HG1/eijwK5L1JhqUH9/sgt
 Yn9Zy7MzZEMb+VIUOUSGJ+AKUUzcUHixSu9/vT1HlsvtQwmZc7NhVgAQwYAYhJi2R3OT
 NDwkMtmkoWU43ueLyN9+CYg0mUg9qWmjQ0dFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714672229; x=1715277029;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlhkT8J4DSi99CdUIomXiK1nZ+fwXJ7RdhpX1jWAuRM=;
 b=r+FEvbjyZ8u5Ql02BS0goCKCg6rtwerOs2zfhGzqunmMRU/tGHbzXY6oVLUTJOLtoQ
 6KiUzK/2OICzzyTXYspzBVXNtB8ftGEWC0PUFueNAAqjw5NgDRtk5mr6fpgZL9C+qJCm
 xpI0pnukh5Kmu20qjSKo1UeSvuCkPt2vRc6c73bnig4a0r5MLHmpaHLbRdXL+LBZ19+J
 ZMFCLQ909r1V4ZwvwFal82S0L+cZxUhkqC/wIrc9XhzX8WngbTwlxhkMplRIs1Fup6X7
 WA8CJiOPW39h6isKHbHGNmcoWvF/GToERCeOhpNSPnEurP9HPooVlJ9TXr1tDQLqlfG6
 OV1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUeUNQ1dvBC/FNjdyS8r5iSqLOPgjywLnktTamvNC1qlcIABp6J4aXpJcoh8MKwNv5lZXZdHS4Grfh0KCufkPNPOMfOA==
X-Gm-Message-State: AOJu0YzrQfub4t5wVCi8Okcy94pk/EAYbti1RVahHYjGunqNxgvBcaWp
 dGUC/bqdAgorPJ6N8ts3SqzhxHp3sZb7NRqcAgzEvWK1V60b2ug/EkuGEZ5nOmw=
X-Google-Smtp-Source: AGHT+IFz4Z1IFeClkzK5QSkA+LhZVV7dUmsY4JkJWWCGv6Y5snSEe8szLunaYJVigp+6shNeV3PJtg==
X-Received: by 2002:a05:6871:5b06:b0:22a:1cd5:dc5 with SMTP id
 op6-20020a0568715b0600b0022a1cd50dc5mr656582oac.20.1714672228961; 
 Thu, 02 May 2024 10:50:28 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 q13-20020ae9e40d000000b00790fb3787bcsm539774qkc.4.2024.05.02.10.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 10:50:27 -0700 (PDT)
Date: Thu, 2 May 2024 11:50:25 -0600
From: Tom Rini <trini@konsulko.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Ian Roberts <ian.roberts@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: sdhci: Correct ADMA_DESC_LEN to 12
Message-ID: <20240502175025.GX1054907@bill-the-cat>
References: <20240501185331.1189647-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="waw0umLqnsx/ZGqe"
Content-Disposition: inline
In-Reply-To: <20240501185331.1189647-1-alexander.sverdlin@siemens.com>
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


--waw0umLqnsx/ZGqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 08:53:04PM +0200, A. Sverdlin wrote:

> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>=20
> Commit 37cb626da25d0d ("mmc: sdhci: Add Support for ADMA2") introduced
> ADMA_DESC_LEN =3D=3D 16 (64 bit case), but it was never used before commit
> 74755c1fed1b0 ("mmc: sdhci: introduce adma_write_desc() hook to struct sd=
hci_ops").
>=20
> "sizeof(struct sdhci_adma_desc)" (=3D=3D 12 for 64bit case) was used inst=
ead.
>=20
> Confusion probably originates from Linux commit 685e444bbaa0
> ("mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode"), but
> the latter "V4 mode" was never ported to U-Boot.
>=20
> Fixes: 74755c1fed1b0 ("mmc: sdhci: introduce adma_write_desc() hook to st=
ruct sdhci_ops")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Applied to u-boot/master, thanks!

--=20
Tom

--waw0umLqnsx/ZGqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYz0l0ACgkQFHw5/5Y0
tyyHPgv+MEifz9deVFukybBfNegD2Iz2+R7KNSXeI+CIvC2M4E5sYZkXrcvyTLnY
45IXNmoRlF6dKfmMmv8wJgDrAilLmxylDS7RK8+hXpSN4p5jVL/d7YcvFphZgFCM
ZNIDq+IyXprirafIE7apxajD3BHEhcROS6X3Y8Qq1bxjKO6irhj/594Ur1RTBAWZ
VUxU4au1C/auX7GyvXUZ8AUkqUD8Yg6sTnv8U8CwxFIs97s+onmLLjg0zH/J2XEw
1T/zNwFOM205ZwYe2zXoMwgUVbicYK7LbbbVRQk1DoR8hlcTGpYaercKXIl8uDAH
4I0c6r6fABdoDHPf9thvlWHM3JHorHd/1CxBDP9zD6C/LibauAgUQ2IeOa0DTmIM
42T2777RyLFM7L0D2kY/2coqiMCzR2qghGPe/R9YDS0/M9V3lT9lVAqh5/1xYaW0
9GfS4NRXpjgf2xC1MeayXbAy8WQg5cReKsl591ukEkc9nYd2dpG6EgQRweIg1+3p
PEpE4vjO
=v3CJ
-----END PGP SIGNATURE-----

--waw0umLqnsx/ZGqe--
