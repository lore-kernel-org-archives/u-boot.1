Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE66C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0375388189;
	Thu, 28 Mar 2024 16:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ANDeTuOo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C8E88150; Thu, 28 Mar 2024 16:09:36 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C54B881B2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-696719f8dfcso5456126d6.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638573; x=1712243373; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LvCO0vTT/IIUEzMQSxmEwV7cPsaCd2/IGGQQmjiMxUQ=;
 b=ANDeTuOoLKc1lP/FJQQwvdK1rUkrbALltr1nx/uBarA3LvMsR40uhpT7xpQTMKuuKm
 k4RIOJdfc5SEQBgzh70JBf8NaNqBHsmrN6Ua4XsgerrOCW/leM6p62i4NzvbLALw6iwA
 DxK9pBqU/S/RomhNeHLYnATdPDNKs6prZ1Few=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638573; x=1712243373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvCO0vTT/IIUEzMQSxmEwV7cPsaCd2/IGGQQmjiMxUQ=;
 b=i28ygnV4JSP5vwYty42xoVu7tu2pE/KrjSPk0Sy+Zu5ZB985Xsxl/K7epkw+PsvS5+
 kZeUBNlys+rWLdSPx4mqPtsOYAuVpZO/0JoUZM009rgEGRte24vKc8x75S+dFrUiMotu
 XfjB/+aO8fKHQc+FT/TuzU7zhm1AWeCKajk/83VnxFXHUC47a4eR0A8np0mzf6nmsN5H
 BYq/9/2I8gt0KNze8+AR21EpttwwCprSJpqbFVEHgDAhK0y86MExQxq7/+6CTBF6kssy
 rImMeCN2DTc2YnQqKDxok6vBBYl3D45/2iJT1l40G6nCSMNiqFR9tWofMlz/v31tHy6D
 HMxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyufFvTRzgsTkKbE8CuS9FEH5hIxA5YT/+mDlNPvKZjxuKNyB5eqWh3bzRt5C0jEmyrBUUGsh1tPfvApDYS7WPekYRFg==
X-Gm-Message-State: AOJu0Yze8ffy159iA+UWbernyXDayZbljgjUtZYC5L1+irm7s+lsbyr4
 /3AbVSsdW7xIdlZOpmdQyUUCERnc4bnPAQExOIAMMMOhEeT7eSYDbTk2b2g4HOE=
X-Google-Smtp-Source: AGHT+IFMqaYfiOElv8auT6rqLvHjFKCXkSCZsDR6sL95854tKEzv909XSavfsNdfAx5c+vRw6oUdGQ==
X-Received: by 2002:a0c:efca:0:b0:696:7315:370c with SMTP id
 a10-20020a0cefca000000b006967315370cmr2948769qvt.29.1711638573005; 
 Thu, 28 Mar 2024 08:09:33 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a056214062200b0068c8be959a0sm713484qvx.111.2024.03.28.08.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:09:32 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:09:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, srk@ti.com, s-vadapalli@ti.com,
 vigneshr@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] net: mdio-uclass: Bind and probe generic Ethernet
 PHY driver
Message-ID: <20240328150930.GB3442575@bill-the-cat>
References: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
 <20240305-for-2024-07-beagleplay-eth-v1-1-e1294a575cc1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WefocGNjcuQ2KEa3"
Content-Disposition: inline
In-Reply-To: <20240305-for-2024-07-beagleplay-eth-v1-1-e1294a575cc1@kernel.org>
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


--WefocGNjcuQ2KEa3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 03:24:53PM +0200, Roger Quadros wrote:

> If DM_ETH_PHY is enabled then try to bind and probe the
> generic Ethernet PHY driver for each child of MDIO bus.
>=20
> This is to ensure that GPIO reset handling is done if available
> before MDIO bus driver scans for the PHYs.
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Applied to u-boot/next, thanks!

--=20
Tom

--WefocGNjcuQ2KEa3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFiCoACgkQFHw5/5Y0
tyyCIAv+MIVrjgCTZMDV+vCE29CyX7QZKQenrQWlrj7AIQjQwUxB1UJ75FUyKn/j
/thfBWkVqA6Ywc5D8jGQ4eGMVpmVCO+fIsgl8M05yb3Pyo4Lo2kcLaAA68Rh+LT9
kqXg8H8nR5QK9RRyMJ634oNvLnV9myVxMlvmIl0jIuHuTHC3k97MUpAj+Qt4lP9P
Om0p9NkEV/o89JuJzO3yOssv2Aq4KCsTL3EM8cFaPVV4iSYMHR9R/lcDTaIpJ71Q
R0p2DhKN/jb31EyYRH5ZA5wcygP8b/nCTkZJRm7L8cGiertN6lTxh/6JrV3FYSbk
V9l+O75Vq6fJqx/m+FfRZXRhPplXvgOYXzEsSpmgeDpdvx7+G8q2c40IpVs24JzD
1ED49iZNqkG0DWdOCu0c7F3IB5Ob32GMZP1c87atkdGTyl8As9L21CEdHeaB+gqo
01HdMAlrvTMbvpbQPsmmAWn8Lz7Kv8A6P1Qbajppb+2JCQrYGtK69z3Fpa7QsTJT
Y+HOUpHF
=tghd
-----END PGP SIGNATURE-----

--WefocGNjcuQ2KEa3--
