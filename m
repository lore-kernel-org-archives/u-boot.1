Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C395C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 18:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF923883BD;
	Thu, 16 May 2024 20:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kyZxOUxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 561A6883AE; Thu, 16 May 2024 20:22:31 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4751883BD
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 20:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6a0ce3e823fso44756926d6.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715883748; x=1716488548; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Aq7si82leRMzwvQRVxnDYZSwKyyg2ui2H049xRMigxA=;
 b=kyZxOUxASkEnPetEjrRcaM3YBCiUQVfvRJfnUzIzNqaM4GPJiK9fHAhBR4/eCc82gy
 Ht0THiBmy3yKzA6CB1wGpHTxF6h7diwiLlSzTv0eabNKl3sTm5ikm41pWgqM5tkPQVM4
 JTO45lsie7D3POrPDBTursf1R/Mfph0oTpVA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715883748; x=1716488548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aq7si82leRMzwvQRVxnDYZSwKyyg2ui2H049xRMigxA=;
 b=DRTyFHlqD5rNJZo+MjdHB27mxDecrMHNxGmGgWlYHFTA0IJLK5RLmwyXH5zJercXGm
 OizrXLodu1i1UL8oiE7TnXinL3agn6vXzH1ZhNZ/JCDyy+s28TJUM9/d6FEXuNWDjebq
 oNdgjfR0PpQXTMB6cAEIuaHXrx2J1nNb2zuDHtNPWlgo4P5mSA2D8w/9iZZwDMlp7FWa
 Q2eFpXhJ9QSFN77SCAyUjAbWEQLzWlvB5y6mh+nzZDa6aWQO5TnpSSU1TxH9jHh8tSvD
 leMnauZUYywJf84pVFwKd1Ltk+2cp3nt1mpSpBUkyTMQOcrApjrnLdSkOL1pktrlmUVZ
 Xk5w==
X-Gm-Message-State: AOJu0YzX2dt9hbydIhlGnHcvUniLJrdF26srPDJZDMHOrCx8mJncttKi
 zQOPAO/xKK1glGo5VNrSswNcK0YqdHkzzlKKpe7o9DBq/YGnoimJ6XysqZyYNXQ=
X-Google-Smtp-Source: AGHT+IFO+lBupVTog1A8ETu0Hh41tbu4xFIDKjf/0XqCAGlVlGrZiUGwPrDbWaK/AuO7Mf8vfhiCxg==
X-Received: by 2002:a05:6214:2f90:b0:6a0:c934:56c3 with SMTP id
 6a1803df08f44-6a16819f324mr216932846d6.2.1715883747579; 
 Thu, 16 May 2024 11:22:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f17960csm77525466d6.25.2024.05.16.11.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 11:22:27 -0700 (PDT)
Date: Thu, 16 May 2024 12:22:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Aswath Govindraju <a-govindraju@ti.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240516
Message-ID: <20240516182224.GE2568172@bill-the-cat>
References: <87cyplzt7i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nJyj0854iAZLegYU"
Content-Disposition: inline
In-Reply-To: <87cyplzt7i.fsf@baylibre.com>
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


--nJyj0854iAZLegYU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 05:12:33PM +0200, Mattijs Korpershoek wrote:

> Hi Tom, everyone,
>=20
> Sorry for the double email, I missed to include the list :(
>=20
> Please find some fixes for master:
>=20
> - Fix cdns3 low power hang via fast access bit
> - Multiple dwc3 gadget fixes, mainly for USB support on TI AM6232
> - Consistent USB_GADGET_MANUFACTURER for PHYTEC boards
> - MAINTAINERS file update for u-boot-dfu
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pi=
pelines/20737
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit c8ffd1356d42223cbb8c86280a083cc3c93e64=
26:
>=20
>   Merge patch series "arm: dts: am62-beagleplay: Fix Beagleplay Ethernet"=
 (2024-05-13 09:15:51 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240516
>=20
> for you to fetch changes up to efbc11ccef89030ed54b7368458eeaf9ec687c77:
>=20
>   MAINTAINERS: add USB gadget regex to u-boot-dfu tree (2024-05-16 13:28:=
45 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--nJyj0854iAZLegYU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZGTt0ACgkQFHw5/5Y0
tyzhPAwAlzIumTUWpSCLKWiTByaT5D2G1p6uJARS8CnFr3UO8djj6cEqnIYmBlPW
FiPOW1bONE+orlZ1Jk4STy7P4LbJcx3HFWegfLqwGw54O9/gAPF383ch2jLFhR42
3djQ72QysKQ/D1UuxoBhTO/whFIxZ6yoImfYUaCdF+/ZIUYENMJGO1X6U9u8X05c
gY+UkLGFBsz4Y2uw827ryqEYjY/OaQRrEwb7531jLjCadTZmtxP2g3Vsg1ti7cj/
rMX4S20NTYJojvoRx0XzcuvNXhCqtZpYGz3mt3yyABkGeFL2bLukJOWMNjBppe3A
bBA/1pH4gg+sMpHhGhPmZ/DpXNGuwRGissvx8W6YCgFEDeoIRk7jOFwulH/qb6T2
WvtUaH82BDy4NVsfgizjrA+aW76cnFDxyUJDlAVue5C1V+YF9+1dS+ita5Ta67s+
iimERWktoDfIr0z0BcUUmhDw3cHlk+SYlRwMTkifV5XHzs+M3N+icko3FnRTIuh1
4xudX37d
=Y5TF
-----END PGP SIGNATURE-----

--nJyj0854iAZLegYU--
