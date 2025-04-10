Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546ECC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB754839B5;
	Thu, 10 Apr 2025 09:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j49ei5mF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 931D2839BB; Thu, 10 Apr 2025 09:19:43 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B138209C
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso3397385e9.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744269581; x=1744874381; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLQlgrMoy82GYCbXYbFq6unl2OVBU5LRa5pWPRzOI9c=;
 b=j49ei5mFlpRxtaSTuLqx1ed//YCl31pFtNuZydU9C1ksJsMaiuFHbhZjbY2q0c15Hc
 ijDsPOwDE9/Gbkk7RKEB3tVJOP+ZGv1ryUuIX0k7wwvtUV29m4cizG8fS+c0XNRH0g+x
 5plpTJ9GCS2NIoEGo1t5uLLzNEUJ7w/SAiVCSpf3s+5WKtJUBTZFlKTMXZsz2PZ1DVuX
 z2bn59vHkMfhQ5L9Y+iTD2VewKMcoNYSu0L2AEqkx+tsPRMLPwPUe+6t5VOZuPRo16nV
 8fs5jk1wcr3A0zCPtOr2kSVGj3sQowIQrxr1VxkDMqKD/i2pqVQ6BNfQdEWyW4aIKeXF
 f0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744269581; x=1744874381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLQlgrMoy82GYCbXYbFq6unl2OVBU5LRa5pWPRzOI9c=;
 b=cFnOPC0hiqbKbCRocZgn6Prn+kRwwJiZhJOkH6TAuOFhVS0KoeTK6E+uZuqRS5kLrN
 Xi7q4FRfl2CgMUwdeSREs68shJ96hnTujt8IWD4HYsxNPKIZxOcG4csopASAYFWsb0a/
 24QVKSvyUEqVS5B4H+eX59FadZwjlSu88lcmNK7wHXG67Bh+rKRrvmhcw2BRkkG2NcqI
 ij4l0jy+JbuupTcWtozd1B2SRy/JO9iv7PQU9DhE5G73/DYjLfeDmlu6ontBrsq1/hld
 BaRdn/eZ+CVDEUbATDWTqRdbhn20snAiG5/oXhCQT6iajn88WcxHkGNJyEIvRrl4Hugu
 rDoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+MUBnh3/1o8sBivmZ/zdh9XzfpIM9oxOem6eGzbYxtHe2p0G10RZbT3d2uyz8M7RKqkwhppY=@lists.denx.de
X-Gm-Message-State: AOJu0YzRk9bZd1t7jcMoknj099Vo00cMVQib/tliwQzXTR8gnMhjCFn0
 wI8V3eq5BSBa1rCComurOLEQyJv/DBSiOLTC7JETI4In7gYe9thg
X-Gm-Gg: ASbGnctI87Tijz8d3yu4Fiu7WgfqcXwVUOKY6CEohCBZxKSbg+96HeaV52pV22OsAJF
 +yZ9uIF9mDg2RcQ+QFADMOSe3RqXXDL9uBM8rcYXvKoQ6WPO3NtQcdJPi09m8YzRhEwtrO6o8ul
 EVbANqGjG6/SB5d65pFHLCaa8t0rSU1Ab6dv0aA3TZrnExwDkI80GBjGw/9wS0CMOAkKUwUz+t1
 O/dzMAHbOCZaeLeHobtEMyVwEEq24gt5gxw5yneVd5i7wtaHMvizph4PQe/zneg2nLxkT7VIUv+
 DH4/Nq3h0CZyiCyUvAiSBUowQSd6gEU2lgQq7RQpSVvkojHf9M5bJQ/dbbebcdhHvYW4xL9TvUz
 hL0CiSh5UIdmrSqIE
X-Google-Smtp-Source: AGHT+IGfNqlvzVtINcMCObh8Pdg/NUrnf3i8B3l/L4y+h5lADSteCrZVRbbmzwMvHJyYENlMhRmtRg==
X-Received: by 2002:a05:600c:4e14:b0:43c:f8fc:f69a with SMTP id
 5b1f17b1804b1-43f2d7af23cmr17600255e9.4.1744269580932; 
 Thu, 10 Apr 2025 00:19:40 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2066d26bsm45444395e9.22.2025.04.10.00.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 00:19:40 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Hans de Goede <hdegoede@redhat.com>,
 Olliver Schinagl <oliver@schinagl.nl>, Iain Paton <ipaton0@gmail.com>,
 Marcus Cooper <codekipper@gmail.com>, Stefan Mavrodiev <stefan@olimex.com>,
 Paul Kocialkowski <contact@paulk.fr>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Ian Campbell <ijc@hellion.org.uk>,
 Adam Sampson <ats@offog.org>, Zoltan Herpai <wigyori@uid0.hu>,
 Siarhei Siamashka <siarhei.siamashka@gmail.com>,
 VishnuPatekar <vishnupatekar0510@gmail.com>,
 Rask Ingemann Lambertsen <rask@formelder.dk>,
 Aleksei Mamlin <mamlinav@gmail.com>, Peter Korsgaard <peter@korsgaard.com>,
 Michal Suchanek <hramrach@gmail.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 Stefan Roese <sr@denx.de>, Phil Han <pengphei@sina.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 Jonas Smedegaard <dr@jones.dk>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heiko Schocher <hs@denx.de>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 7/8] phy: sun4i-usb: Determine USB OTG detection pin
 from devicetree
Date: Thu, 10 Apr 2025 09:19:38 +0200
Message-ID: <7788519.EvYhyI6sBW@jernej-laptop>
In-Reply-To: <20250409002036.12212-8-andre.przywara@arm.com>
References: <20250409002036.12212-1-andre.przywara@arm.com>
 <20250409002036.12212-8-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne sreda, 9. april 2025 ob 02:20:35 Srednjeevropski poletni =C4=8Das je An=
dre Przywara napisal(a):
> So far Allwinner boards controlled the USB OTG ID detection via the
> respective GPIO pin specified in Kconfig, as a string. All boards should
> have the same GPIO already specified in the devicetree, in the
> usb0_id_det-gpios property.
>=20
> Convert the usage of the Kconfig configured GPIO over to query that
> information from the devicetree, then use the existing DM GPIO
> infrastructure to request the GPIO.
> Only PHY0 supports USB-OTG, so limit the GPIO request to that PHY, to
> avoid claiming it multiple times.
>=20
> This removes the need to name that GPIO in the defconfig file.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


