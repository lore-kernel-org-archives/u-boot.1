Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEBDC27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2AE876A1;
	Wed, 22 Nov 2023 21:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J2Xja+LI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E7A7876A1; Wed, 22 Nov 2023 21:50:23 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A15478768E
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5ac376d311aso1962417b3.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686219; x=1701291019; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G0cTISa5VwDOefU0Rtb5Lsqmd0RrczfnuLcVgKsDz9A=;
 b=J2Xja+LIDgUu9Z43jGmySDiCamXE1FDUYiFpdPiTDBulNxFu6ZP+l9rzgbu/3eDdZn
 GtbVnROnrSQ5xt9Ryk6gsofn0QcSVt5Y9pAaT/WLpU2RJe1ZK/qveJ0NpPVaeoqmMrlt
 m3ki78iPEtKEx+2yxAvHuQ4J8wnUmh9Tk4L4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686219; x=1701291019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0cTISa5VwDOefU0Rtb5Lsqmd0RrczfnuLcVgKsDz9A=;
 b=irixZiA0ifGeR31p4tTpctGuvGqAMjUheCJbYRRa/jfg/usu6evNhvKp6OdZuMJDQa
 bBWGCpgH14ey+J+P9Ivt8b0RH7Ch4WyUVInsD7PWBw6Ip5uY7gtpc+rNQ1cMGpgs9R3b
 gTj3WS9eAq9eSeEYXLb/nTb2K2xb57HonE4qKzF9AFe7dj5Cy9gNCzRNT/6vxQ3agzi/
 HKPrNi2lEK+PA1pdNCNTPblUeB6A1incDAVAVtmSKOnQ00kbnGXkoU/oKPNmBknfswM2
 MkHKgfkQETPkBtwo3HzB3BISbTnIq2jL43E8H9uZz5+fMQjAQ69CfUQHhwid1K4GxBgm
 5KUw==
X-Gm-Message-State: AOJu0YwRZmDwf62MaFt8NeCz095Yor7PQimHt4USw7OMxwqIgO6VatxB
 fQCkx1QB/VU3nmgm+CAvPlT5Tg0lFxbAPl7AOuG9Ew==
X-Google-Smtp-Source: AGHT+IGBOZet6wWu0pzTQy7ySI8ahiOCdBitOCiCCv6uCzdY+PtlwFxcascEKYV/9JW8GS0oH3eDeQ==
X-Received: by 2002:a81:8904:0:b0:5ca:84d3:23bc with SMTP id
 z4-20020a818904000000b005ca84d323bcmr3339166ywf.48.1700686219393; 
 Wed, 22 Nov 2023 12:50:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 d200-20020a0ddbd1000000b005cca9169319sm91689ywe.28.2023.11.22.12.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:50:18 -0800 (PST)
Date: Wed, 22 Nov 2023 15:50:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: sjg@chromium.org, marcel.ziswiler@toradex.com, u-boot@lists.denx.de,
 vigneshr@ti.com, nm@ti.com, u-kumar1@ti.com, kamlesh@ti.com,
 m-chawdhry@ti.com, afd@ti.com, mkorpershoek@baylibre.com
Subject: Re: [PATCH 1/2] arm: dts: k3-binman: Add support for FIT templates
Message-ID: <20231122205017.GM2513409@bill-the-cat>
References: <20231115101024.3441093-1-n-francis@ti.com>
 <20231115101024.3441093-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S+qTynweYarRfOJs"
Content-Disposition: inline
In-Reply-To: <20231115101024.3441093-2-n-francis@ti.com>
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


--S+qTynweYarRfOJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 03:40:23PM +0530, Neha Malcom Francis wrote:

> Add templates for FIT images used extensively across K3 boards with most
> of the code common. This includes the FIT portions of:
> 	- tispl.bin
> 	- u-boot.img
> 	- sysfw.itb (in case of legacy boot flow)
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--S+qTynweYarRfOJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaYkACgkQFHw5/5Y0
tyxNNQv/dVyVpXV96peqRNbBT8NbJnljY+m+rg0kjMYslymH43rXTKARtcelI7H5
d/+RK6Qd4PvHkMFeJx3ObI3usQNvXdbxVNaHFh6iHntkTya/GujmQLRC7i5a9hN+
6o8dGOpi4ZNyeJ3Vg/1SAYwpU25n9ggmAuGtPwVn8Y6jz7X7yN2TbQQmJ1iwbU46
HdSb/juRw9REJs1q2LbW9OBAPmgDDa8AEUmoJPIqzwmj1paAtWcX5ZfVBKAWdfVg
a/nwQtA6KCscto4QFheEuNZp/EmxKkcUEyFR4cZmjS+M9Xk4onwDej3k7tzl+fJ7
NFiBVo/QV9HOou1ACTD3lOn9Z5FT5EFouvxBIS8tHX4q3iji22U3W6erWxvyXSzb
mD44qB6nW5dWvPd5zj9+UgKk6gPqukkHAe0ND4mdhSBkBYymmD8xK94pP/XSilHz
IQIQb+uoZmN9OULEhpBToQCRR9+RLzO7FFLlU6xyYsavfyW/Nx38i51DCLuYQqQ4
fPZhhBqO
=T/I+
-----END PGP SIGNATURE-----

--S+qTynweYarRfOJs--
