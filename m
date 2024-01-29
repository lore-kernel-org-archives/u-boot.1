Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E28AC47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643A387CCE;
	Mon, 29 Jan 2024 18:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jHz4sxSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D7C87CCE; Mon, 29 Jan 2024 18:54:58 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA39D87D64
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc22ae44595so3345981276.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706550894; x=1707155694; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dJET5ywRfZ4G4OMpk7pQlwdxH0IQcqnk5vi/eWLzKwU=;
 b=jHz4sxShtwgtf2l0I53BE7EAKIWPR5muK1p49wR1lumkRP9FO9/sVZjE8sjPXTjkLi
 hr9k0u1fT0y8oxklWwUnjaKPf0cN2uZ/ipAFphpAjKIoiXEr3LIyBaXBLrgxHnsWScRI
 TVRcgdiI4H8lhY/BJd5KOuHWWO/d7EsWH+GL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550894; x=1707155694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJET5ywRfZ4G4OMpk7pQlwdxH0IQcqnk5vi/eWLzKwU=;
 b=lZGHGkuNxWuQYCvmQeegXumAh4d1mZi001gf0OnjVlhuhpX9hx3G33scl1gc1ZG7eP
 0crYghOwq3phNFPCdcm+ASozLgV+nN3USPVMFoEDbH9eK/j3ZeDdwD+wi0jy2S6Ah1ZF
 tYuHSTzR/5nIqCd8c1mspePiGN1y4M/Z7G/qvTxUqNbU6/WHPiGi0WYyCdCh966rZw5j
 iZpbcbGgY/9b9hY5YopRgFt+W4+8n5RQbxc6aTB1lKgTGMKdcuQC0sh+U3/lMMrp/qBo
 v5BP7sv95K/PoWQrBueySVfZNL7OfyucqiFHuJNWP9MCXCGpylumlQjP+T5lbifvN0DE
 MutA==
X-Gm-Message-State: AOJu0Yw7+6PAt7m1ztAf4nHdrWdbkQzJ4Bai2Qfww2tFr33QTSLUGE3z
 gcwlLkDRWnSgzhQ55Dv42nx8868+niLdTqNI+8y9J//RW9SEhSFvI5Qic6Far5Q=
X-Google-Smtp-Source: AGHT+IGykoYwEzBxnat9jeyatobXHBhMCDcLqyHKGb3tLLFdJdmRuWYsnfuUPQiFASPUdC5x1PIQ/g==
X-Received: by 2002:a25:ab05:0:b0:dbd:54cf:a6e3 with SMTP id
 u5-20020a25ab05000000b00dbd54cfa6e3mr3590671ybi.12.1706550894668; 
 Mon, 29 Jan 2024 09:54:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 64-20020a251543000000b00dbd15c3b753sm2409998ybv.46.2024.01.29.09.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:54:54 -0800 (PST)
Date: Mon, 29 Jan 2024 12:54:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: nand: Add tests for NAND flash device
Message-ID: <20240129175452.GC1152441@bill-the-cat>
References: <e24fb8aa7d61923eec9901683295c65979496044.1705674029.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VXVVVT/qQT1tS8D3"
Content-Disposition: inline
In-Reply-To: <e24fb8aa7d61923eec9901683295c65979496044.1705674029.git.love.kumar@amd.com>
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


--VXVVVT/qQT1tS8D3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 07:56:19PM +0530, Love Kumar wrote:

> Add tests for nand commands to test various NAND flash operations such
> as erase, write and read.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Please fix:
test/py/tests/test_nand.py:62
  /u/test/py/tests/test_nand.py:62: DeprecationWarning: invalid escape sequ=
ence '\s'

--=20
Tom

--VXVVVT/qQT1tS8D3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW35mwACgkQFHw5/5Y0
tyw3TAv+K+RtW2fGLwEKWsiC3tFcIvVlXfhLsP/5qJD39nOC6rars+/f/81ju5Jm
T7HCv0kgdCqeaVH2tNFUm2mW6twS22mgd7YecJkcHomjv/qZHywRiBptJBANEMX3
tcydTIeRu2LRnRTRYO9bFXdMmfktfi93selKLZUvmvc81gGHK+DXHhGlV+DO6+6n
FMHT/WPwzylpxgQEdlzquw+8dRpiyPvAhXoxyC/NbDlz14rq87JUnOADRTDfvket
6wfHfwU73yGpKsuZKCPH5+JU+MBX64tgoUfvJXZe5h5us1v9NwxlJnJUvklIg/RJ
fx7SzFqFNQ9g8HS3ydZEMZLLjr1veBZ+UqEyX3gDp8SegjZAv2L9NXuB3DRFRED5
0K02BVsIUw+fYGnyFbC5Y+M56qZYpk1wLE+SYa+TcSkunMC/YFKbIGtA7HJqWcFP
1KTrxDV629ZBackq0J312Z5I5SIfEqdRUVudnqSTb/moPhVarDtFg05QDyrtVtVR
aNokYcM8
=1kOo
-----END PGP SIGNATURE-----

--VXVVVT/qQT1tS8D3--
