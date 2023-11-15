Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4D4C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614E68704F;
	Wed, 15 Nov 2023 23:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MAnYM1RX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7279E8743F; Wed, 15 Nov 2023 23:37:04 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ACF3869F7
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-45da9f949aaso46431137.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087821; x=1700692621; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zgGOt2P3oFWE4en7x2z+yg0WP4b1W5jOhwYdNS12cDs=;
 b=MAnYM1RX46xCVREvZWonCUrKJjicHKuzQ1R50UGbuZXsrlXJcAPVtBUVDb/Wj5nxpZ
 bfcXnb8GbobVnq3X/sa+OezRCmOLq/S4hvjJ0yxsti650jbzPnomuykdkUApHBTobbT9
 rcD9fXfkEsT1OfH+tajFIKz1P6atGrj4VpWrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087821; x=1700692621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgGOt2P3oFWE4en7x2z+yg0WP4b1W5jOhwYdNS12cDs=;
 b=vkN1y4sHvpVLGSavOV3zhZwclHsyp0QwmQIFn+Av6wps4nnMyvO9lSrtJdghFSb9Th
 Q9caHuiGC1q1/uRJwb4Qe+IU9KACdZvUGyRTGQrOL3g1xDPWK1A2Ox9jOHNmvwhmr9ZR
 VMEySYT75nL8oSqxMTsW8+rxZnjZDwckkLdqm0R+jzCv+/WhF0NanbJ1/E338gFiyC+Z
 oXhT0LIer1l3e5QlVAljcBLLHinbnq/Hkyw7qNrxchIDwEVOqcbv5Bt+f4CvXlufS9mg
 XOGREqph1/dETyQabDSZIPudV1PTheVzrZabDXV8DZF72lXDf3dPL8/SnRRAcmdxk2bQ
 O/sQ==
X-Gm-Message-State: AOJu0YxBU5ZkhfF57MNPcE+lKAPPWnEev8wzNjp+WrWPAcr4hLGa1/uK
 ipg/+xm4tX6182dzDsiURAWTLQ==
X-Google-Smtp-Source: AGHT+IFSpNNoFOqnbILYtISUy1GY3RyH+4rPCHEFY+Zrrc6M/gVW3/hqu5FWmk6czLKrqUzs9VagLw==
X-Received: by 2002:a67:e0ce:0:b0:45f:8319:a005 with SMTP id
 m14-20020a67e0ce000000b0045f8319a005mr11394969vsl.30.1700087821026; 
 Wed, 15 Nov 2023 14:37:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 f5-20020ac84985000000b0041815bcea29sm3845191qtq.19.2023.11.15.14.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:36:59 -0800 (PST)
Date: Wed, 15 Nov 2023 17:36:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 13/29] bootm: Use the error return from boot_get_kernel()
Message-ID: <20231115223657.GU6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-14-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y1b/CuYr+G36xHoO"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-14-sjg@chromium.org>
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


--Y1b/CuYr+G36xHoO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:58PM -0700, Simon Glass wrote:

> Rather than looking for a zero-sized image, use the error code returned
> to determine if things are OK.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Y1b/CuYr+G36xHoO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSAkACgkQFHw5/5Y0
tyxRqwwApFypgf6fVzt4zYlXOILZysVKiig5vdqnvRZTefOdez5wBOGu4/eoBTPq
HOPIiTun4FczszPp1bZRvIM5AIcYkRYtDrCXFvcgMqVM2w+oUwzKYgeuxFRp2cTA
OwsB3rornf+ntTgU8f4QCL2tjUokDqZ8jqo1wem9Ai6X1Flx7yLJTeE3B9GIV/f8
3lR5e1hFd6vNSlWHBkrUYA/tDKM7oDmyJ7k3qMtTzs+rKoJhLCboxH25gVhdE0Ky
/Wv/ZYBww4ILDLGKzgzFu31X7l5gg4+/CYDRNqPwcddUlQSQZaGfLsV0noxsFRXd
4T1yQDSyvSE1J4hiOcVR+ZTpJxr9QoJAzmQzadT4OW8bG/W9AFuPTvBhYd72HpPo
BINTeK7Ml7qxPufgLRPZvd+S4Om1hH2MV9bjIAt+CgfcVCRVQNwpvv5wCiU/SmIm
QZ4YWrxSLkJ5y7t0GZ4YDmef9QAW1ojHQCivXGMZVm8V0b0eg4YuF0XNvd6/Wv1D
1Fuc8/Q8
=+Rz3
-----END PGP SIGNATURE-----

--Y1b/CuYr+G36xHoO--
