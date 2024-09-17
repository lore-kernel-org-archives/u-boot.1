Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E15FCAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 23:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F1E288E8A;
	Wed, 18 Sep 2024 01:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TtIh8TIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C6488E6B; Wed, 18 Sep 2024 01:48:31 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595D888E9F
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 01:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-45aeef3ce92so18710921cf.2
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 16:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726616907; x=1727221707; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9lhVQCuEvzHXLqJxST+n3ko9SElNfWsZy41wH5Boqfk=;
 b=TtIh8TIEHpv/iaCV/EUtg/TMneOx6xD7yeXpent89c9JaVD1RZbgIJ6nNyzOw/1gDc
 fHy9dRkF7KctGlVxzpR2Cm4Ntl3htBHixOoMClmhI+8hjYv0eua9/XAsFfaHTQOCtEfL
 HtQdlweEVfG41pQUAx0NdEyEq1JkA88jEiCDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726616907; x=1727221707;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lhVQCuEvzHXLqJxST+n3ko9SElNfWsZy41wH5Boqfk=;
 b=usVYu6VUIaXS0CVfOXRZmLSuanIwKYvuECtHUk+OYyE5KI48IW0Kq8M2yQSX9RYjZT
 xlq75MuCbypq5nLAf69cIbLQN76uKyavqcapWBJ5dT3X13SdMYdi9liW756bq3tdg35d
 aHaowZUyDfGANzB/k1hSXHOnRQJuCpPokgZ7YQH/6MB4QPoikZZ7MFFD40xendpSjE7m
 9OlVbV1enk+pqtZhwDGP9ztkBF53Xb77JHb8nqbdYxC0aBSo6llOlapqsMR3iBq/cgaB
 T5HppPwx1OLptd8r7jMvXt+X7lnBo8U/lDshpR8CdETBT03YMMD6Ah4XD95U9b6uIRMw
 kBkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9WuB4HFe3DBnrD0KqPa66gDRvD6Z2tfrOyw2lTOzQXYjAR0AaZzaAJoCI97Q6p+XsEObQUhY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywh2Vvg0Y+AtY/swp9rzEJUBduYTDKHqBV2x0pPyTm6KyaR+QRM
 sHwqa+ka0XphQRra2yfuhpyWkhXwqTCJNWfKLGRTWCJsJ9c66bjiGoPtTb0+D9c=
X-Google-Smtp-Source: AGHT+IFkS8un/ln9XwP6vh4nOq6ittfLTWswXWWHSLf2fRpkUJy0EANxUu9ZbQIipBcXF6Cvf9QmKg==
X-Received: by 2002:ac8:5907:0:b0:458:5011:6671 with SMTP id
 d75a77b69052e-458603de430mr331793971cf.39.1726616907170; 
 Tue, 17 Sep 2024 16:48:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad2497asm43429901cf.95.2024.09.17.16.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 16:48:26 -0700 (PDT)
Date: Tue, 17 Sep 2024 17:48:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Oliver.Gaskell@analog.com
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 u-boot@lists.denx.de, adsp-linux@analog.com,
 Trevor Woerner <twoerner@gmail.com>
Subject: Re: [PATCH v2 00/20] arm: Initial support for Analog Devices SC5xx
 boards
Message-ID: <20240917234823.GR4252@bill-the-cat>
References: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7zf6pe5lNwz066mz"
Content-Disposition: inline
In-Reply-To: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
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


--7zf6pe5lNwz066mz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:50:41PM +0100, Oliver Gaskell via B4 Relay wrote:

> ADSP-SC5xx is a series of ARM-based DSPs.
> This comprises the armv7 based SC57x, SC58x and SC594 series, and the
> armv8 based SC598.
>=20
> This patch series includes configurations, init code, and minimal DTs
> to enable Analog Devices' evaluation boards for these SoCs to boot
> through SPL and into U-Boot Proper, as well as devicetree schemas for
> the added DTs.
>=20
> This patch series depends on ("arm: Add Analog Devices SC5xx Machine
> Type") (https://lists.denx.de/pipermail/u-boot/2024-April/552043.html)
>=20
> Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>

This generally seems fine, and barring feedback from others, I'll take
this in to -next in due course. But I want to stress now that I will be
expecting bindings to be updated / reworked as needed to match what's
accepted in the Linux kernel and I would prefer no (but will accept
transition window time limited) support for old bindings once new ones
are accepted upstream. Thanks!

--=20
Tom

--7zf6pe5lNwz066mz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbqFUcACgkQFHw5/5Y0
tyzvvAwAlje0D8VmRcNu2vsUCbM4+rPZCOv3nxY/AKzojZueibe1KTpTmQU4MXqU
64blQE23OwFTE3KAElniFIJhWKrpoc/DwRlwqLHGLAMekm1j4cJU6/Uy3PvdIugg
t+jpydwUZMtzBE97eXumpAMKN4RPntTys4ug9n/aoY+yERRXfRdXF4TGL6bZRTAB
hrSPi+sKBePTKhBZvWSj6g9A1a14f1w1BbYHjOLtXOk7ljdox8pctAutzSn/gRK5
/9QOjm5l2PU+5i+8M5wB/Ib3XjZnUdp7WgGtIdfif0PgcRWlXXd2o6Y1uzURQJs6
cRFRLGhC0mF/aqDAzw9OC2WnXVKk057oINP+dY7kAa8kOdV76P5gQ8yH1+KORILQ
rzjMPdUGlBCtK9X2YGUobPV4giE+GvkjVHSFuTZx8CYhsUpx1WQyFxw+PISyW557
KLi+9Lok+UpQcLgGWDbPHlxWLAREPqmGuoXf/EyjhhFj4OUCx/O30I2IHWRKAHHS
BOAWuRvz
=+E70
-----END PGP SIGNATURE-----

--7zf6pe5lNwz066mz--
