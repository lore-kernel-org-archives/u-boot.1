Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BB0C27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 13:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D69878FB;
	Sat, 28 Oct 2023 15:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W+2nouR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B4787790; Sat, 28 Oct 2023 15:27:10 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF1387BB9
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 15:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b2f2b9a176so1977954b6e.0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698499626; x=1699104426; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4FDF0xg3AtVC3kdkIN2wF7klGAgVeYFprfWwFZ8zWys=;
 b=W+2nouR583ZvKoyS9FG2KxFn7ksAjV+oY5HNcl9YfcBj55Y8uWciK2rWfbNEnlimQb
 ZG5r4Z5+ILG128omngxsA9/bcql/SbU+nym0kPVPHeHNVtsckL7kMWNb1c6MTvQaw6e9
 ZvAule1gBqlqrw1AHt6PjESXx9PpKP2VUGDCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698499626; x=1699104426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FDF0xg3AtVC3kdkIN2wF7klGAgVeYFprfWwFZ8zWys=;
 b=sxK9SPvfJBCu2OndE3DX50ZtcnbGfwxaiGU4PWg6ktuzx2+LIoqGL/hlhz6hZLWe6B
 DWQbGoLh/uRtJQZQFzdyGqKHhRVs2NPlEY7W4xxoCxqy/l+P/h/h5+tz3mRuYScxqS4O
 v67GkOBflp2GxrNE3py3WfaieveWD55W2zmAS/Pc/UqkcSj+SP/WduleoAAxs2ybdNi7
 6WGm708hgyvpabgcQ5ql+pTGFtOonnYmfT3qqPqOd/2LQstx55w/VP9eW0vcPlzxBM29
 2/+KqdSguS+zF9lHoD7cdlfcJ4Ou658skHFqJoDDZi3+Mx/tX3ivHEaJByGoTgBfDLo1
 lxRw==
X-Gm-Message-State: AOJu0YyEyLentRImMeJ5S8vXzvmP5Ly3PWTYYvTpFCDPADXXiIN23o9A
 3FqFWaTck8STPHIw4hPK7w7/PQ==
X-Google-Smtp-Source: AGHT+IEalidfQB+1bvxD6TJcyMX2dr+gNNhMx8/xhxKvvEhHItXETBJRwyp99OkX+omxs4DLmrYE4A==
X-Received: by 2002:a05:6808:1490:b0:3af:8ed3:d7a3 with SMTP id
 e16-20020a056808149000b003af8ed3d7a3mr5809945oiw.54.1698499625911; 
 Sat, 28 Oct 2023 06:27:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 ew3-20020a0562140aa300b0066d1540f9ecsm1607148qvb.77.2023.10.28.06.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 06:27:04 -0700 (PDT)
Date: Sat, 28 Oct 2023 09:27:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, bb@ti.com, sjg@chromium.org,
 peng.fan@nxp.com, ye.li@nxp.com, robimarko@gmail.com,
 u-boot@lists.denx.de, n-francis@ti.com
Subject: Re: [PATCH v3] driver: misc: k3_avs: Add support for thermal shutdown
Message-ID: <20231028132702.GJ496310@bill-the-cat>
References: <20231019072752.1330935-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GdRtKAleUfA8h/JE"
Content-Disposition: inline
In-Reply-To: <20231019072752.1330935-1-u-kumar1@ti.com>
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


--GdRtKAleUfA8h/JE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 12:57:53PM +0530, Udit Kumar wrote:

> To avoid thermal burn out, program thermal shutdown
> value in VTM (Voltage and Thermal Manager) IP.
>=20
> Part of Linux kernel driver (drivers/thermal/k3_j72xx_bandgap.c)
> is ported from kernel 6.6-rc1, which sets thermal shutdown values.
> =20
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Signed-off-by: Neha Francis <n-francis@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--GdRtKAleUfA8h/JE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU9DCUACgkQFHw5/5Y0
tyzZaAv/WPXjNcdLao4Pbhj4CWdLQO7dYHB6b7DF9GcmjGuU7OreBfUBt5UV4rvJ
rNXHYU06xa+lLTekprrPyAUbAYYf33k/hTDuAZXewjRF6Shy6lENQpTKqTdgj8YI
MuMhhqcLS1A1cwFNe+HNY4nv3pFUuQrK+XUX+ad1jxTClr+jXlsDPscTJ8zbORZN
V8095Qh0GR81FjyLbF8iTpXwPehQDBDVTfWx4dvr2NRiqJra6ZnhvVb5piW0U65z
yWNNedw9xzi8gPOkc+l7oNdQyD7wELtbB470IoVf+atukKKuhCLztamcN8GmhOcw
4w+IHqGsPnE9JJBDOZMFY9UUKT5cIeGx5koxvxMeioIxb41rTBJxD9H5jBC4E1hG
7eUXSuRr1SeXPTnkDrC3FrL+OJkd/Px1RG8jJwhJU+ZM0/bjRGFP9ORWjtG1bcoH
PiyMDk+Bly8vV2BZjl+YU0OMaiRMiMsaM8qvsjm3iCm5l7aKLUpxV1xG9CvPzYIP
tfMP1y2+
=T03r
-----END PGP SIGNATURE-----

--GdRtKAleUfA8h/JE--
