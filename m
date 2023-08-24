Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6270C7EE2C
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1048786699;
	Thu, 24 Aug 2023 16:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XFT33NsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7147286699; Thu, 24 Aug 2023 16:53:13 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACEFE86414
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d6b1025fc7aso6294036276.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692888789; x=1693493589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=obX14rZo/JPSs830QO2h5dtej4u/Q0NY6KgAlt7nDTM=;
 b=XFT33NsGYGLsGgILCAqJQG64HV3s6CLLj7fKaoN99ah2ty+cuCwe/24KQL9QnTtSyv
 bwatZgdBjlr97N2RU/kOVRXVF3xN4zd58oF3ccOP0Smm+A6l8TNWbyCzkzro5QYo4SKk
 NQzk5hs6JAB02YHTAm9ZjHpkaibYQGgAuMVCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888789; x=1693493589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obX14rZo/JPSs830QO2h5dtej4u/Q0NY6KgAlt7nDTM=;
 b=k2yc7BwPRoxQU/U0RYgNTLTI1ZZZ61QVeIzRllYwmhhmBezSCSLGQhfEbUneR8Zb/J
 f1DQNbW/L8NQeM8ykwpNYeQNExd9tPaPPx5KwYz9r7xCilwXJbgRlKQ9df3oOooL3SLI
 cUf8FDK38gs8kf+d+OHXEGQY0i0D5PWz6V8WY9pGBSWsEczuIWyadqs0eU2icS3or71i
 0lHwmz90li2IHfgjpJnIjsI9VJeCHEgaWMP3QbhJSVs1NH07JJDePWCknfRHq/fQpENZ
 XvfffH2W1VlZTE8K3BaOr3sTjatj8krSiq3SqYHOXlPYGcO2gspcKM0WoLU7Hkskj1BT
 QQuQ==
X-Gm-Message-State: AOJu0YyfInN9XG6wnAwFhakhisatIYEov857E6FzgicSOuDsX1J2aAIN
 Lw/G8RSlmY3ZByhYlSpeWOnDOw==
X-Google-Smtp-Source: AGHT+IFB2Y7IKel+Wb4TngPlhwkpRspx/8CXLfXbzYWlGEjiM6XukEfw4HiI4lhtMyGO4uhg9k02BA==
X-Received: by 2002:a25:ae10:0:b0:d77:e7c1:5537 with SMTP id
 a16-20020a25ae10000000b00d77e7c15537mr3702285ybj.18.1692888789229; 
 Thu, 24 Aug 2023 07:53:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 l80-20020a252553000000b00d7823cc7d62sm54750ybl.19.2023.08.24.07.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:53:08 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:53:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V5 03/17] include: configs: am62x_evm: Wrap distroboot
 with CONFIG_DISTRO_DEFAULTS
Message-ID: <20230824145306.GQ3953269@bill-the-cat>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-4-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QWfyESdllmLeqMlk"
Content-Disposition: inline
In-Reply-To: <20230824031101.3460411-4-nm@ti.com>
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


--QWfyESdllmLeqMlk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:10:47PM -0500, Nishanth Menon wrote:

> Wrap the distro_boot options with CONFIG_DISTRO_DEFAULTS.
>=20
> This is an intermediate step for us to switch over to
> CONFIG_BOOTSTD_DEFAULTS and drop this section in follow on patches.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--QWfyESdllmLeqMlk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnbtIACgkQFHw5/5Y0
tyx2Kwv/ValN0aheI+c5d3oVGZs4B9+CaJbDmwVFOrIFxfA9EqZOwU6cXFG9Br88
gOGxsW5kZp88LUW8Ty7EnzX7GOeG+jeF0wSIVX/egXXV69rXdtS6ws+AkbAkKTrN
YcBydOfgHa6lrZBPWqbOeyZNiasV+b9CEzbIe0V+twuz2MrxYrY3smH8XkluSfPu
WS3Hf2bnqu1u8vKsAs05koQPd9D0tJy3NKe67BlKFOtVPUP26vTKG9oHTthc5MSj
RhvxeZ3zY7JrkzE3Hab7A0/cryALP+6/DP0WhL7tBHXdtU+J4cgrtXUbdI9z8y8x
QFmwXFVtKN6A/e3TcgkOZ1tbpthyAEpN8SeFIxxKS5Ecnxbx5k/euGUTv7QMZEUr
sVWOEKq32Fmei+h1CGIfyG5YSCnfQ8nR6uSw1Y3YONi/35D9RNXyjvhuXU1LxOL0
YMXemwQMyKK2Qf8jjOuKncggcujo6Uyzff08d6jySrYbGZ50/nqN9nfd8oSwtQX6
wtfjr1od
=UmNr
-----END PGP SIGNATURE-----

--QWfyESdllmLeqMlk--
