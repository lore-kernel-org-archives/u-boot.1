Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A5FC47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BD387D52;
	Fri, 19 Jan 2024 17:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t6Xv9Ry2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF95187D68; Fri, 19 Jan 2024 17:09:51 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B754387D32
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ffa694d8e5so3331807b3.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680588; x=1706285388; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cRMdfSSPoAxEMaloSPw9hy5g9+N99C7VrhL9WfHnx3A=;
 b=t6Xv9Ry2UGS6AKshmqfcA+jvtM6r2xDKPyuXoVhb8j0KcFSfhQjdMUDTuUaaDc3A1g
 VuBUmqnaTLZWBnL49pNuXAEVt7dDY1MUxU1g7ooU7Nc3UUlZ1VnfkGxfvo4lSvtzhL2R
 IwnTka59Q1ej3vgg19Iz+zkSUNeg1doPOk8ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680588; x=1706285388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRMdfSSPoAxEMaloSPw9hy5g9+N99C7VrhL9WfHnx3A=;
 b=aA3zf6lrkjsE7bZvjehRO9IPXnTVi11IEysUlSz3mTm8rXuRhQ1pw9du4c/LojApUs
 nwJe/XAYshSKa73BzT6MDQjY7dOdOJSuGgAYoj6O+7q+3bWWSd8IpOqL6fLkt2KIH4g8
 e8SkBQyppYb9ql86Mt0rVA/CvASzywG4zkrveHSUMuckWolP7GWB+df9mcgET6HA6vRJ
 3HCmI0LyPNw0fO8WAnx06AgTJ0cwQa0H22AKaOshwMURkJz6AmFtD0ScCK7G6aXcCRF2
 w5+y0XKWIkg/830D+qVGp/vcr6r+qY65B6peIZoO04lwnjoIaUm6XY2lbdpw4vBfv1rn
 Fusw==
X-Gm-Message-State: AOJu0YyquDnt2tzj/AMt0DStaEJX5MjA25qGMYonYoeV7ZmfLGCqQJB0
 tJHo1PAo5lMXFQpCFka0jblNr23q1mz9QTaktwAb+STskqCBjhW00ve3StGB8Iw=
X-Google-Smtp-Source: AGHT+IE9AAM/w8o3XYtvbny0XdG3/wRICkP+TTNmYSkw0YiqI/vBZqFvlT1rf21kFkRInsX3YqpSmw==
X-Received: by 2002:a81:8386:0:b0:5ff:9568:b1b5 with SMTP id
 t128-20020a818386000000b005ff9568b1b5mr838653ywf.33.1705680588476; 
 Fri, 19 Jan 2024 08:09:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 x70-20020a81a049000000b005ff5fc95e2esm2788497ywg.142.2024.01.19.08.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:48 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Moritz Fischer <moritzf@google.com>
Cc: bmeng.cn@gmail.com, sjg@chromium.org, wenbin.song@nxp.com,
 u-boot@lists.denx.de, mdf@kernel.org, patrick@blueri.se
Subject: Re: [PATCH v2 RESEND 2/2] nvme: Update nvme_scan_namespace to keep
 trying on busy
Message-ID: <20240119160946.GF12635@bill-the-cat>
References: <20240110050448.1441657-1-moritzf@google.com>
 <20240110050448.1441657-2-moritzf@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w1FiIAbQiO4Ab8Ev"
Content-Disposition: inline
In-Reply-To: <20240110050448.1441657-2-moritzf@google.com>
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


--w1FiIAbQiO4Ab8Ev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 05:04:48AM +0000, Moritz Fischer wrote:

> A busy controller shouldn't be game-over for all controllers,
> so keep trying on hitting -EBUSY.
>=20
> This change brings the actual behavior of the routine in line
> with what the descriptions says.
>=20
> Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Moritz Fischer <moritzf@google.com>

Applied to u-boot/master, thanks!

--=20
Tom

--w1FiIAbQiO4Ab8Ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnsoACgkQFHw5/5Y0
tyzC0wwAhNYoR1D+yYSlaRQNY0qr9Pe6My7YRGDnsx4IwwEUFkaEAybE56L2yDWN
aaVg3uWsXfuVZg82L8cmPcv9C1CiwLCJAbs7ju9Og3wvr/Df6brJDD7YmvrIEMxp
qTmyGqdPd5l+sxpj+lR5NVVA8h4NbM3Ymu1nOtk0Kndn7Bcv4RF8AOVki29gmZ8G
yON4pA0B48Bk4SdyFnicnsWAEQUzCA1U14lnZ/oP+izD7DZAUtbgjdXNT0lObGZt
50u9U+UTvAT65y02CrQL6JSuMZiLmPMQxrdnUOL4aqU4B7Cs3u13hPGJGDzfihhl
g90MzZcdM8YjQ2H1xV6/x23g5NoVeYAEZZNA1midGy+YgQlTElU1BfYRr1mq5npD
ttn1DIw8zBUeW854aNtqo63G/T53liLg3484fU/9JsYIbfuHxBW6b63CZzTyNh2w
fMfelLqHSm6jBnUTjYcwalvusygEljgKlvQcdaZSJ5UPv70C28JWqVRMYVZ4sN0L
UAuArm2s
=oFGG
-----END PGP SIGNATURE-----

--w1FiIAbQiO4Ab8Ev--
