Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DEACCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A6E8425A;
	Fri, 10 Oct 2025 16:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WkIJt8gT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB2F83F58; Fri, 10 Oct 2025 16:28:42 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F10A83F58
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-43f912f9738so1087558b6e.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760106519; x=1760711319; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PYZQLvBcsm8+mWeiDL5yIODtRyJG4LJtNLjTwO19SzQ=;
 b=WkIJt8gToCCQCeTiQafEEb01AFnzAq3m0+SKaEfTAjpGPEMkOxxAVf0AuxGtTw0Vgn
 y8XNOD6nc6BH4LNORGdI340MTpOO2m8rQ4Ew7gVj6P/a4zuMk8Qv1eMJQsaB8YeL6a5p
 CF5UVJ8m0pjjWPsQGtLQpl5LfLzOjX6lmiIEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760106519; x=1760711319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYZQLvBcsm8+mWeiDL5yIODtRyJG4LJtNLjTwO19SzQ=;
 b=B2PS5wQFeYjrRKLtryyK6CGZOxFRc6Vhrrczcam+nZPOJA7Gbp0ozhPsLEdoRviBq1
 as/0K3jTm1vcSPkzQGKt2ZJF7pxxB6VKCJ86QVvMT6A0AEIc8S/RHMfCDKkbbRQQWkBU
 WKg5selgvhhMCAoAjZiFidOjyqk4u6W/QdBqtk08DkSA69fCExIfPETpo99ltA39spmA
 S4QSMj7+RIU0PRIFC2ButrbfGSS7mngRcj/VwaJJY/sWo9vhJaVjumsoQTQotzMKaSnH
 lcLqDbgRht8p+apyBFWsOwNkYedtz/PKsv783ItFRKrpFyTxeelSfgG6fI1xy79vUBQa
 j6bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3esasG2yvT4DFan270ivAasHy9Pz6Da0ZthKo/3OeXr9FEzt1ZAsGoPF6MT5RDt2gBxJEqdg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5SzhbrhUuKfL9cBa+XVV/TsELQfZowuSlPEGagf9NUZLZUvIM
 Sufj0zhxQuVp3ktASAE347RVUxzyjB/bLECabzTf6akM+nnDOcqXkx8jXM0GtIIRvRc=
X-Gm-Gg: ASbGncuvnhZ+u7Z7AHzhijW1tRbpl3MeKwUABRZnYrUIsgyaSQFKE0fEkdFl9yEQxRa
 sE4T4FKVQbrYYqbtlUOVzkwOJCBTPgX4dXdCA9MVFq8dUWucB6PTbU2JuX7AmeuK95/g+jzHmL2
 PsDsOXU5Q1roXrLDncFIbr8lP7POISNLp9A7hggaUTTOYhFqF8XMivDdWCn+/rJKO6eCCDuyjcj
 paVUha5qV6/8mF+LNuxELYqmYFrschRxM8jr78Fw6hP1PlP9LFw3yYmb3qlbbqzCvttK/FbCQYF
 qf9YclJwtV2+XIHhZzKMqdjh6wpaQoza4Swmirx3dGKzkZmINk2I1mD0SB/xemmyImp+GfdmQlZ
 8XPASn0cIKBUunuOk7B4GnjjPHpUj14z6PPBMS2PDzBr8I2BT0is9umw+dW4ohR8umB8VEnsJ1o
 zABdRw
X-Google-Smtp-Source: AGHT+IFxIajTEbsTAuw+fVt3plYZF8kezw3VKI67xGLIKmaFzaAceBhZBNZKlXaucHCOLWIenIMJMw==
X-Received: by 2002:a05:6808:1527:b0:441:8f74:efd with SMTP id
 5614622812f47-4418f741aa4mr2703937b6e.26.1760106518700; 
 Fri, 10 Oct 2025 07:28:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44198976d5dsm654213b6e.26.2025.10.10.07.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:28:37 -0700 (PDT)
Date: Fri, 10 Oct 2025 08:28:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
Message-ID: <20251010142835.GY298503@bill-the-cat>
References: <20251010053056.32495-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9bZ8VDvoH9NXasAg"
Content-Disposition: inline
In-Reply-To: <20251010053056.32495-1-mibodhi@gmail.com>
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


--9bZ8VDvoH9NXasAg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote:

> Make it possible to disable CMD_PXE.
> Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX config.
> In extlinux_boot(), invoke pxe utils only when
> CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
>=20
> This patch results in about 9K reduction in image size when
> PXE boot is disabled.
>=20
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>=20
>  boot/Kconfig             |  3 +--
>  boot/bootmeth_extlinux.c | 18 ++++++++++--------
>  2 files changed, 11 insertions(+), 10 deletions(-)

Is some part of the symbol logic here wrong? A challenge is that "PXE"
is also where the logic to parse extlinux.conf style files came from,
and I thought we had split those two out. And then there's this:

>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 2993cd7f9ba..403ce4c3d46 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
>  	select CMD_PART if PARTITIONS
>  	select CMD_DHCP if CMD_NET
>  	select CMD_PING if CMD_NET
> -	select CMD_PXE if CMD_NET
>  	select CMD_BOOTI if ARM64
>  	select CMD_BOOTZ if ARM && !ARM64
>  	imply CMD_MII if NET
> +	imply CMD_PXE if CMD_NET

This is one of the things where defaults isn't supposed to be so easy to
get out of. How many platforms are you wanting to then disable CMD_PXE
on to save space?

--=20
Tom

--9bZ8VDvoH9NXasAg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOkYDwAKCRAr4qD1Cr/k
Ct0RAQDU9UxE6FTBFawZoVpN5HM6cvWBAlOGyCouVXWJQYa+lwEAwBIzMvyifenA
QBNSfIrkQdvLKIkWUhNwNO1h7SFNLgk=
=JR96
-----END PGP SIGNATURE-----

--9bZ8VDvoH9NXasAg--
