Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFC8C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E1D88137;
	Fri, 12 Apr 2024 20:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uCvq3VGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D97E88020; Fri, 12 Apr 2024 20:52:08 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B5A587E91
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-43651d93568so6433761cf.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712947925; x=1713552725; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UBrXP1GsPSKHmAciI5aXNRM9VlT2U3dBUJDiNkpIkD0=;
 b=uCvq3VGdEwsHTTsdzY9aPihTORmfgeqAUMXpoDd4WGsICdBdJv3ftYFuO7tS8k79Y4
 +VVMcSOH9lboLOLP5m2s0WQaamujbOCZq7NIKmmYWnQHAz4Ay49q8q6ds3dEFktwN8Iv
 GxPB0+d9x3yIXwdrZZk4VOlNvccbI0ErH4IT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947925; x=1713552725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBrXP1GsPSKHmAciI5aXNRM9VlT2U3dBUJDiNkpIkD0=;
 b=rgza6bYZ298b5c7mZ2uhYyohSjpltLd6uPD/9bM4ywpNHy85MpR4IjOwHoD2VQL28q
 +HyUFiNCYlVhx2L+1du//e/kEGavDGW/kq5G9QcMz6pWDrDbutMPJny74gEPfF1Jzdx8
 HsRXq/2oiTCV19fNbzguc/a9UKseXr2rZNFqZ2T5heH894OKUL8he0WO3d/ChKXNrecM
 Dd2/C5Uk0ejehS8g3j6zm2Aas0abWuqaiO+b7bNcxBQdZ4OhDMrOi2/1kW34ZcJdO0Ep
 AL+2+kF3Snc8BGwpYB8E16ZQfMTvEfT9slxRjgI109EvUCKSmGvAm97G4ACP3Yy6ipNj
 h73w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr2er1gxrNQZloHyK2LqYipePZ7qS0MSAyuEXQ4eLUgtcLaJwfEW5U6CiTOMfD/4gAGo2CJ57isesgVAq7B2wDkic2bw==
X-Gm-Message-State: AOJu0Yx+83DPmXt9U4SpRpX1vCrdMcNPOWn8OtNRy0R8Rzn+qNnc7UUb
 hCo3esYGn5krS2LpOQLyRyhaWPZK5gqjPQHntBf0qULj8kYoKGwv0Y55tIvT9XE=
X-Google-Smtp-Source: AGHT+IFhex8JO0wBnwAUX7Fjx0Ab0C5n9NR+sV/9aOuLdghU6Cf1irvnDonoTWo3Lee5qyO6M8eBCQ==
X-Received: by 2002:a05:622a:c:b0:435:a8:342b with SMTP id
 x12-20020a05622a000c00b0043500a8342bmr4852808qtw.36.1712947925186; 
 Fri, 12 Apr 2024 11:52:05 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 fu28-20020a05622a5d9c00b00436510ddc5esm2547284qtb.34.2024.04.12.11.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:52:04 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:52:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] sandbox: improve description of CONFIG_SANDBOX_CRASH_RESET
Message-ID: <20240412185202.GQ2493117@bill-the-cat>
References: <20240212083730.33956-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1XmDNIRBTq3PFqa4"
Content-Disposition: inline
In-Reply-To: <20240212083730.33956-1-heinrich.schuchardt@canonical.com>
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


--1XmDNIRBTq3PFqa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 09:37:30AM +0100, Heinrich Schuchardt wrote:

> Mentions that command line option --signal is needed to make use of this
> configuration option.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--1XmDNIRBTq3PFqa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZgtIACgkQFHw5/5Y0
tywyVgv9E2PJJjIQhkOQKjY59eUtM1dummCc0fwo5S03Guc5QBqrI3NuyYOdmFT0
hommyXeJajA3keqrLtX+mcIxVKnOQw0vk25Algh6XwnY9WngSihTlTd8f6pDIjqF
XkBdOAuVBedQjNgpBTTeCJXbiUrfDPHPhyWinMhievELK9CrlhC2sq2tctMQcbwX
qiWyWS61luAAYgsQdb0JMaM7qtig2rQdnMaGRS3Fvj0Wi86yr7ZibKEWbylHw2n9
v4wA3p6ajyEacKV2ufhCtHBHme9nSLJkcKgSmOsZwqYca24KhV0ikq9c1ZUC2rGp
ssylM2OpArzh1H4AITnwpfm+P04C4LvzMiYCg3Yb1pB6JEimkOwMRO5f0QN8G8am
GIKLvgvU5Crt1ncdx1dFsI2+wbkncKiw9IVuNX1ulZ972iWel4Pgcm1jP8/TYv3X
u9N442tbkBG4hQkTulvfs3G18d7wp24Get0ecFnqa3XdsOgkAE2i3/a0Ab2U6AkD
EQfhWAiX
=OSfK
-----END PGP SIGNATURE-----

--1XmDNIRBTq3PFqa4--
