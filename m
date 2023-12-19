Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB43C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACDE2877D9;
	Tue, 19 Dec 2023 18:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FWWaH8Aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4259187775; Tue, 19 Dec 2023 18:46:28 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1DA9877E2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e7db780574so5951547b3.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703007981; x=1703612781; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A30MA/yfET745yHg7Ixb4MIaMEWC+PSJ2BIs9zDlcnM=;
 b=FWWaH8Aj5VTcKrJOiCx9bs5JBQOSq0FUYzBL2LWNWACw5nyMpy8I2OV6jQOC6dhotK
 mUl2pcy2IRu/wg38dX1DWqUHzWIjxS9bt6KGbXOCNh08HUM9JWOHZf/iaIlICfQ6Vrcf
 8jYeoWIR9JLpM46H0rguVEMCWb4U+Qegi5w5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007981; x=1703612781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A30MA/yfET745yHg7Ixb4MIaMEWC+PSJ2BIs9zDlcnM=;
 b=d7a84J8vrShbFzb1hAeAkbNrHEckONFFgpaKfDKRD7kwviBkl+qH3bbXdfkHp4RzTn
 SC4XTxFNjrv+cN4jthBavzbZZl4KQi1GG5AGUiUh8H6cUhBF2UEgiwSmlwtCXZSm3XwR
 rT33oUk4ybRKd8+tYNZVzgfSj16WlHFgQMp+w7BLxHCzuIUlYqF8AFH2X7Vj3YPAbGWm
 SsN7bd/PU4ti8qZ6J5cMziB18a8dDVHgfwqvfpDOd3mcVU4ucyIzSDrbMrkrKjNpMlkp
 OM3KWh/TL7oQWkq9STZJj2jQJeG7+jNKHE1GRE27O7UqDRi7lDI3q9ggh2VcmX3wvLy9
 kI5Q==
X-Gm-Message-State: AOJu0Yx3aJ9YaXF3Hc5cLN1HaubP7bHlgsxX9dHDWXcQ4znmYzbDP7xB
 mR79a63XDwDr2wFeh3yXj3ibRAlGDunVYrZXDVI=
X-Google-Smtp-Source: AGHT+IFJT5eDKTHX/jpecdpLThYhiqhPOsPp/UdMaXAynX5r2N5LIatu8gFvDeDsQheBzkjsLcOIfQ==
X-Received: by 2002:a81:7c82:0:b0:5de:93b6:7044 with SMTP id
 x124-20020a817c82000000b005de93b67044mr1011465ywc.31.1703007981519; 
 Tue, 19 Dec 2023 09:46:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a0dc702000000b005cf1ce8b96dsm9920725ywd.5.2023.12.19.09.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:46:20 -0800 (PST)
Date: Tue, 19 Dec 2023 12:46:18 -0500
From: Tom Rini <trini@konsulko.com>
To: robert.catherall@foss.arm.com
Cc: robert.catherall@arm.com, u-boot@lists.denx.de, andre.przywara@arm.com,
 liviu.dudau@foss.arm.com
Subject: Re: [PATCH] arm: vexpress64: juno: Allow boot from VirtIO
Message-ID: <20231219174618.GB2513409@bill-the-cat>
References: <20231123182258.15928-1-robert.catherall@foss.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SfbdpbBDafuVhfnJ"
Content-Disposition: inline
In-Reply-To: <20231123182258.15928-1-robert.catherall@foss.arm.com>
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


--SfbdpbBDafuVhfnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 06:22:58PM +0000, robert.catherall@foss.arm.com wro=
te:

> From: Robert Catherall <robert.catherall@arm.com>
>=20
> The AEM and Juno FVPs (Fixed Virtual Platforms) support a VirtIO
> disc interface. Adding VIRTIO to the list of boot devices allows
> these FastModel platforms to boot from 'disc' in the same way
> the hardware counterpart can boot from SATA or USB.
>=20
> This is a NOP if CONFIG_CMD_VIRTIO is not enabled, so no impact
> on Juno hardware (which is built with vexpress_aemv8a_juno_defconfig)
>=20
> Signed-off-by: Robert Catherall <robert.catherall@arm.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Applied to u-boot/next, thanks!

--=20
Tom

--SfbdpbBDafuVhfnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1uoACgkQFHw5/5Y0
tyw7ZQv/R9aHJNDtYzrhxnLTnQzOfejaB7AJGatm271REBIMy6gTBB2WG6YMhuqo
IS4skcpjStfPDANH2Jb+6TYUq18QMcFptuT/Effab9z9CwcLneeHh1IXHpYf8iv0
tmmkyxdKT4kkKduoYnAWNlhnO6o+KjGVyfNeEyvvSMvhzw+DKwMUQXls9AWV0Aqo
8qfluyEMbOhpM4motFJvkO9Usl7nxoNR1Qnt5G259fLo+LfEEtITt3n64X7kD9gf
ZAxNg2FQ30mLV95IpWIYm+E6Ucpcm86yh8C111Zc+v/tmg29GaeNyHWhcRsAUDzG
KazzjdX994jP3GreN9CbNYFIr7OEumMeVdOF6otYucYfCpJ+JT9aCA7piPBRl5jz
3pO89eZ8oXRN6d6Qwa7bU+yiHTgtzOFwXoRrp4FSELIkDckqNA7ragLhrY1LW6rW
7nEGGCrCux+NzdWV8+WaTN1DfdYKJYa2FXM1v9Ewz8jWXKrZV59Md/3vNx3Q0flo
tsjMcBN8
=1+/l
-----END PGP SIGNATURE-----

--SfbdpbBDafuVhfnJ--
