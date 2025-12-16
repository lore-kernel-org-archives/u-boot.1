Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84694D637D6
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 21:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1619F83A7A;
	Tue, 16 Dec 2025 22:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LD3nfiwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A8A383A9F; Tue, 16 Dec 2025 22:55:31 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24A058334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 22:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c765f41346so2702182a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 13:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765922128; x=1766526928; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L21Wazpz139dAKtET69IrN9kpyuHwSOFbWElVtx0G1Q=;
 b=LD3nfiwOA6h3nta+vdzm1gpuIz/1gWuxOz6Y6gSLCObHnDl0R+NxcSiicNvcPxgV58
 4SRj+vONQ+E5ZQrOtwOkziD/cQRotcPajwmFrDzT6chLYYk8TRL+ifd6JsLuy9a7w8Jg
 jQs7zi6bwQ4FyrQeKt0wzPZylOKRRzPHcIkSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765922128; x=1766526928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L21Wazpz139dAKtET69IrN9kpyuHwSOFbWElVtx0G1Q=;
 b=VMmd8Uv3IgDdC6BTC68G4DR6IJgX+EjjV6gak4e9Lf6FnswhhxHdoAK1Be0vvkEI7a
 PAz/ggZpHP0uf38K+b0KWEMe1m7OP1rI6NBqhhtRQbxDiaLftenFFtW7fX1aNDApbDNq
 uNOUeT5MCFsedHhek8kfmeaJ00WkmwwXi14sbGQAYyLu9o01QjpOLwGo0HH/NOYS7SmM
 wwaWBoQJQQ0oX7Es2TBMBUeFcbzcbjT6SM+2yC3sW2BFPQLnrueXwH/0UZ0oeT1G1nem
 BHzcc7vZmY9cS5iZeb84xUVU3iozCuMEPGCTkUMvuUdbd07ELUz23bjqayqzC+vfohsY
 /zNA==
X-Gm-Message-State: AOJu0YzLeSSf9Y1ikoGrYAo0l9PlUS1YgAlHCA+v1ZcMsAHraREVVTT7
 m5ceqRw/I8bjKgQ5XRaaLyQ2IaIh+QLjv+EjS1pkz9ahX3MVhKTn+HLkt25PmAbel5Lb7wvBaSO
 KZe64U+A=
X-Gm-Gg: AY/fxX6ZD+UZx0GjULHXOlRGC9iK+KrFdOc1ekqPGRPOQtUp8Dt6ZOp/X1AIOmUpzFp
 wp+u1MiLGdyQbi1mAoCDeVvF3/A10WubE1tpD63lpgQC4Ew61KxhuFPx0/YmANcQDnzT7UApBF8
 DP7qPI/xvV4MgajQWbX0Jqt5aDXlnbtoYHphtkdoUqxj1Qnj2mav1iLOA1zhf3nfQ4e+1nA0lsB
 RO7wVaWzf81brYmdOcqHhH8Nr9juZ+LbRRbdO3YDfi/uhtQOhsqujdkEXsXqgXPFcgNq657arvg
 evgyznVvc8bnHFIORYfnnp59SLszbjVTE4DqJocWIhbLr+FlcuhMAKml0pQCHQKWzBjoNdErHmd
 fa0bwwCIQFHIoAiVW8OeOZXGR3n9tIywBi6HZ8FZfZf/4mlMi3Khfunx8kY9X0Bs+TPXnLmCVcE
 JSCPI4CHhIY0ZllROYbGdN6Ux2cNHJ756TudsqVw7a650ZWRnNWg==
X-Google-Smtp-Source: AGHT+IFA6e3tvMXCQ74wgWjP5CRBVpJyn/2fa0Ah00443uoafFXOmaw30Q2V8M3LFziuoX5L84xCcQ==
X-Received: by 2002:a05:6830:4427:b0:7b8:f2a2:46b8 with SMTP id
 46e09a7af769-7cae8362dcemr10426392a34.17.1765922127809; 
 Tue, 16 Dec 2025 13:55:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb1d1089sm12251330a34.6.2025.12.16.13.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 13:55:26 -0800 (PST)
Date: Tue, 16 Dec 2025 15:55:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Jens Scharsig <esw@bus-elektronik.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] board: BuS: remove support for BOOT LED
Message-ID: <20251216215525.GA303283@bill-the-cat>
References: <20251119-bus-led-removal-v1-1-340218264e59@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sVnYg/0bKBEusykG"
Content-Disposition: inline
In-Reply-To: <20251119-bus-led-removal-v1-1-340218264e59@cherry.de>
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


--sVnYg/0bKBEusykG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 06:27:27PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> We are trying to get rid of the legacy LED API and this is one of the
> last users.
>=20
> As far as I understood from the code, only one LED is controllable and
> it is a GPIO led. When initializing the LED, it is always enabled
> regardless of the passed argument, same for the mask.
>=20
> In addition, the LED is used as a BOOT LED.
>=20
> To keep the same behavior, a GPIO driver should be written, then add a
> gpio-leds node which makes use of a GPIO from said driver, add the
> /options/u-boot/boot-led property pointing at this new GPIO LED node and
> then enable CONFIG_LED as well as CONFIG_LED_BOOT. This should result in
> the same behavior using the modern framework.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Applied to u-boot/next, thanks!

--=20
Tom

--sVnYg/0bKBEusykG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUHVTAAKCRAr4qD1Cr/k
ClrXAP9qmaFciYDTzWMJZUlNrezW9lsyd1pcuNAqcvPhecXAtwEAjCIrI1vPv3Cc
Ig44Ur5HpDuMJ/cF8CuHCspkgBAkAwQ=
=6AqK
-----END PGP SIGNATURE-----

--sVnYg/0bKBEusykG--
