Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D354D2A551
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 22:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 598C683CB5;
	Thu,  4 Dec 2025 23:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ntmFkpRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CCDF84033; Thu,  4 Dec 2025 23:05:54 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB576839DF
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 23:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6597455d07aso730443eaf.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 14:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764885945; x=1765490745; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MtTgNbVTSAxwOB4EC9cQ2am2S7coSGoA2bw+R/Ji2NU=;
 b=ntmFkpRR5CoOxjo4pDLVP84Va+QeQDdQ4JA//lYhrt7b0YOhM8Nn8Pap5Ey0lyAGFK
 63ZTfeGIm6V4zYS0dxlv85H8Qf/azZjACVvMS9gkKWZPwsowSsUxEkTr5KcpLGs+spr1
 5FxNfw9SOtt1PRQxuNnHJlEVNaE/k8W+/jgK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764885945; x=1765490745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MtTgNbVTSAxwOB4EC9cQ2am2S7coSGoA2bw+R/Ji2NU=;
 b=BNR7e7xUk9sNLQ4APaYnAU0d/FPKUHMv6ZcuWI7CZZInf1ntNydDWHyQ6uLWxLzcRt
 GQz9U0SfdTA93Fovhur0nSpuM9I8nToMJ4FdL+s8GAhnetdzKMF0VFxTXpXzA+ekFc9+
 3gzMOsUNnL3GS5F/ymTMNWc1BYTyhc3IVcpfJs3MdIuZLh8w846YbrOBAaQCzokVDdiQ
 JOvlUeI5EonagVRPNEeK7Z0C/Bh8d4bfKNwnCvtFiqCNu2JqCjeNSVmMBJaVjbDRknlr
 W2erupk4vmi7LvJDhTVo4P0/wUxwh2VveAXiFINvMA8FFaIFOShMJiPjUdz/tJH3LaZs
 od1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHW/so3HsEdZ8+EbTKtRAEGa4h7GXO/hPGd4QQj2XGxUBcb2hQDROjTKece5+MqMah0gl/KUQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6PjcDZ676z+1SWJE9j6oNzurAeMwxytW3V2Z6z7BXBvKaa4fD
 wS4Xj9QLAoMNK2WJqbnwIb6SqbShuRhl0B2Gx7fTZi/jb6GcWR/i4URufHRBVV2z6vw=
X-Gm-Gg: ASbGncvhRQroaxJJY8naGVzFI2JUsPQWA5WKC8o+eU8cT447o2+grxIkQybtWPYTXlq
 DO/CBbdMrR8HRTs1niQPTwGi9M6HIKhuMiJAH1kdoSGf1ko+euRNvbbo1k64IsDtHribfnYiPfv
 UPmQagoIOzgqf1GvmAbrJlZGFHbMbYCcor908lx+ERDEYC3qgubZ3q2XX+7y9sIt5GOA1n4Eds1
 uxLjpXIGwTY5burfOEJugwK/7KgqdmwLY6nOPIlWmds4LIWYY/ARaFpoqGZBvQSJlC90Czzn/kb
 klHCaGcMT0m1s1RLfQP/DChmkmzWPX2Dpp7Ik6vGZqBGJSC8i2EK7DgJQ8gzQuNrs/eTrj3G7T3
 YaspWKXOtQv5nBeCgqFcq6EYQhtZTq0eu/c0T1ZbBFBBTAIPsMBAz4LftSZaRTuUl7lUp/yUZjy
 jll4Cd+7El9pV/UpDUaWKAKYZ3QHImnxtDNqJ8BVGzfNYaBFCl5w==
X-Google-Smtp-Source: AGHT+IEbRPZxnQc6pfVaZC6p5X7oDgqxHVj2pg+ucWuBt/V4YyqzrUpe3NFWb3pCpYeQyc3/ezEBhg==
X-Received: by 2002:a05:6808:1a1a:b0:450:1f44:da5c with SMTP id
 5614622812f47-45379ddf9ccmr2729180b6e.45.1764885945603; 
 Thu, 04 Dec 2025 14:05:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453801528fdsm1277728b6e.18.2025.12.04.14.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 14:05:44 -0800 (PST)
Date: Thu, 4 Dec 2025 16:05:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] board: toradex: add aquila am69 support
Message-ID: <20251204220542.GG303283@bill-the-cat>
References: <20251107082427.7480-1-francesco@dolcini.it>
 <20251204214115.GF303283@bill-the-cat>
 <20251204215044.GA13173@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ui425sbFtui39zoR"
Content-Disposition: inline
In-Reply-To: <20251204215044.GA13173@francesco-nb>
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


--ui425sbFtui39zoR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 10:50:44PM +0100, Francesco Dolcini wrote:
> On Thu, Dec 04, 2025 at 03:41:15PM -0600, Tom Rini wrote:
> > On Fri, Nov 07, 2025 at 08:24:26AM +0000, Francesco Dolcini wrote:
> >=20
> > > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > >=20
> > > Add initial support for the Toradex Aquila AM69 module.
> > >=20
> > > The Aquila AM69 SoM is based on the TI AM69 SoC from the Jacinto 7
> > > family and is designed for high-end embedded computing, featuring up =
to
> > > 32GB of LPDDR4 and 256GB eMMC storage, extensive multimedia support (=
3x
> > > Quad CSI, 2x Quad DSI, DisplayPort, 5x Audio I2S/TDM), six Ethernet
> > > interfaces (1x 1G, 4x 2.5G SGMII, 1x 10G), USB 3.2 Host/DRD support, =
and
> > > a Wi-Fi 7/BT 5.3 module, alongside an RX8130 RTC, I2C EEPROM and
> > > Temperature Sensor, and optional TPM 2.0 module.
> > >=20
> > > Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/t=
i-am69
> > > Link: https://www.toradex.com/products/carrier-board/aquila-developme=
nt-board-kit
> > > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > Co-developed-by: Parth Pancholi <parth.pancholi@toradex.com>
> > > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > > Co-developed-by: Franz Schnyder <franz.schnyder@toradex.com>
> > > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> >=20
> > While I am glad to see docs in the initial patch, please fix:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1323274#L236
> > as those lead to CI failing, thanks.
>=20
> Annoying. I was aware of the doc warning, and I ignored it because it's
> a copy/paste of the logs output and I would have expected this to be
> taken verbatim.
>=20
> How can I fix it? The block starts with
>=20
> ```
> Output:
>=20
> .. code-block:: console
>=20
> ```
>=20
> and after it should just be taken as it is, without trying to parse it.
>=20
> Or I can just remove the log from the .rst file.

Ah! So, I think that means you need to adjust spacing around it, and
that it wasn't rendering correctly either. The sample in
doc/board/toradex/verdin-am62.rst renders correctly and without warning.

--=20
Tom

--ui425sbFtui39zoR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTIFswAKCRAr4qD1Cr/k
Ck3UAP9Mo+GJtucfkVzJopaboGhngGsuUlCGZ6RJMqrwKzd9pQD/eCQdkwKOpap/
3/cgQeoM4zK0FHTzCiGYtD9IPdhO6Q0=
=xFbO
-----END PGP SIGNATURE-----

--ui425sbFtui39zoR--
