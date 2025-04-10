Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CD3C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 862BD839AF;
	Thu, 10 Apr 2025 09:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hOMjeXAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EAFC839B1; Thu, 10 Apr 2025 09:18:45 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA248209C
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so4884205e9.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744269522; x=1744874322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igfhmktc4O9/el7E3iil/mb7fCZm4IRQ4EpV0X3Eshw=;
 b=hOMjeXAulN3rd+1eS5eF2J8JlzlXPZALCBcqdrNP3HAeZ2/SQVvrKtlLZ7ARGI95vG
 fsbyZum8ZKBU/xiYbhvAzjdy4wUlmEU4vgyagWTyHbCBBMwNCQZmhLcKdgScKuBVKIjQ
 ZaKBjGj4yce9Pmhu9QlcUW79rdDO9SdNdLCrIDcqC0230CdUqwt4zGERRElqPv7rH+FA
 vNqSAQzx7QN1bwdV9AuNfb8J8x3Tbr+m2cEpiNK92AsgSRpoflGKG2U2ub0QF0ufj86F
 ucrwr6ln5zoC+Flgk8I5oJT5dI69kA2e85rS66NheiKk0Z9NSjjplOj3Lz715cD7F/LL
 0hWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744269522; x=1744874322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igfhmktc4O9/el7E3iil/mb7fCZm4IRQ4EpV0X3Eshw=;
 b=FHCuLJrsczwB+8iRKcUS4WFNKuTxm7qBhaBU/UNYbilqWIXP9QuAbpkCFyegd38+0N
 XWTulJ0Wd9ZK3XgieOLjqXWS0yMNnKLuWsJirez4dsHYfO3MdMt0yU/WnGBGDVeTxjm3
 3HWPAtSB2MByAXQaPaH63kDwSuigY8+e3WsH7Gko7q+MxNwQivDSJQXkWPJgn0442j8g
 3B4UiW4EFRiN+2ppC/ImOhozrP0mLLPGf8/NPTXqhsrkxdVlP2M73unPS6m+/inYfbpH
 NAALkeexgh2A68yg6L9bj+RafxrA1/bHw6pxuAStQqoCcVQmpGr4YhFoWMmn/94UW1WG
 srjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBZogCNm1RwAxuyguTzolW7Tw5bBcmIunz+AhGLUS5cw6kPukKqLAfqsGvp2qWO12KYoSP9Ac=@lists.denx.de
X-Gm-Message-State: AOJu0YyGxHN2AnbKSMXH2ja98WXRwqHRsV0jE+e/e2wGiqPlvxvC90Oe
 YYnq59A89jq7icURYooUZ9+Wj8bp7CpB44KEL4iSqsceThjn583f
X-Gm-Gg: ASbGncvAx7IdmNl1FUu4fhNIWVdz9AgGGaa/nkTnETPATYt1GCx8xpL5pIflXtfJHK3
 6UAqTxqPUczMo2rB7tUYYLDaMY8EtLFRm39tS3ZSgyUha4za2FsbV8iQr2zeD7Gq+jS2nQazrmp
 yc3PncaQhGnQ57pOeXtK9aYG+gar3TKopOaTMsZXW78qfH3bwJQwDlNyv++xQmC6ppUvcraiVCe
 kuPQwJXkmV/+8Iw6eWN8+wWIDIIEYgsVxHSK2aSpimLBfZxDT9C2FlSDNIES6nxDhkN2XXV0h5u
 pvUA6KQyU1V7/ClSjgB7R+FW/D0r3xT1+7NY9RTjtws1hnrgSaSmTnMXqrvYY3CWYVUgdtZRUbp
 Vu24smc+68ssK9JAX
X-Google-Smtp-Source: AGHT+IFfzqNNpQgZzMhSOTBS34F+vVbgXHCLS/Ubmc6J9sN5ZyRsu19rqv4vwg9unKbVYDbMBD/dTw==
X-Received: by 2002:a05:600c:3b97:b0:43c:fc00:f94f with SMTP id
 5b1f17b1804b1-43f2d95ebf4mr14397185e9.23.1744269522160; 
 Thu, 10 Apr 2025 00:18:42 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f20901c58sm28873065e9.0.2025.04.10.00.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 00:18:41 -0700 (PDT)
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
Subject: Re: [PATCH v2 6/8] phy: sun4i-usb: Determine VBUS detection pin from
 devicetree
Date: Thu, 10 Apr 2025 09:18:40 +0200
Message-ID: <1997333.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20250409002036.12212-7-andre.przywara@arm.com>
References: <20250409002036.12212-1-andre.przywara@arm.com>
 <20250409002036.12212-7-andre.przywara@arm.com>
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

Dne sreda, 9. april 2025 ob 02:20:34 Srednjeevropski poletni =C4=8Das je An=
dre Przywara napisal(a):
> So far Allwinner boards controlled the USB VBUS detection via the
> respective GPIO pin specified in Kconfig, as a string. All boards should
> have the same GPIO already specified in the devicetree, in the
> usb0_vbus_det-gpios property.
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


