Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ED8C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 20:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6052B81F49;
	Fri, 14 Mar 2025 21:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pjtgnr3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D7C81F59; Fri, 14 Mar 2025 21:26:20 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5ACC81E5B
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 21:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6ddcff5a823so19963506d6.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 13:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741983977; x=1742588777; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+IEKPEb6SpUbpUVIk3VwSTUdTVFerCLhzvBnxWL0u1U=;
 b=pjtgnr3oYmVgbiua2Kfo8jBcjFMXQHIr6CGYYhuJuzqFQcIeGmDoxdrbbRQh3e0uOD
 LroJPJOB7NTFtCOGhp0lulRZaVTk/vTw5eEhqNz/5FNTcLEwfj7IG+PlkO65/G6tC9uN
 dJmFkCgp9wOKOQjdjYY9lMbsUWmmbbPHRoMPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741983977; x=1742588777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IEKPEb6SpUbpUVIk3VwSTUdTVFerCLhzvBnxWL0u1U=;
 b=sMeiaYRqaywLYW4GP7zU3CQNlFetKOLNQYV8U2i8vKjukjtykB6FJCo6pAVEcXnm0F
 uiTowPZpDjhNfXORH6HlO22NBUgMBLWPsStI8X1Km12i/ZAqA/DiPdscK5zLSsH4zS+0
 ZPly5ww69MlUqvXLkhdr2EpxX97DZjhHlyfQ76oEwGRBJH03gUXoA7P9imHMpwPTh88B
 6L/O37DelJ2Y/4IRMSGtduVUa/b+HxRr3mQc9iOoBM407r+0Bk1PHHrXz84OFrssMpOM
 +kGbcuwAZ+VoA2Cd5AJ7aV3fOm3mWKNrOSFM0j7rnxbf7ONhaudCPiR/8tXqEFr69CUg
 ocfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2CTIvR2N57Vxay2MsnWa9/mUPddC2Y4A59S3dDfuj4JKcTqyFuczXSeHXhpx22TrjXjfMrdI=@lists.denx.de
X-Gm-Message-State: AOJu0YyjIyDzyjVkf7rYHat0VoXuHbYuxm7prxgVMkqyv+io10LiKe3e
 kcSQ7BHF+unFB6doNARDSlr3kDUUC9akQfLVmy9fRL5Jmt5p/ZHL9yeXghxbNSc=
X-Gm-Gg: ASbGncvDuACvYlpik+4k6z+1Hg8vW20BmBk4qEmAoQdwkHf+HhOBC4kppXN7mFR6Qlu
 7kJTTroDsjV6FZnlkDU1wroXBt3KMqwKE33fj4psDe171voYt8ttV+hs+Q7NH9ewwZTGpDkkfrd
 z+V10QcCP6iS8jX/adKp8g+LJHs/hRFjVhwXv7mmj/vWn5m5Z2EAkhE9CuZMNz+knfBj9meALRg
 /TPs2mLAua+bcR6cpYM38Ixn4ULhUi9Lm8BSj4TFUwVTa50TGxkEseYRe13zg419StpPwGAeIqy
 Q6liLkh1fb44iZOBApQYfpjKLbsP7eyQMIUxjS3y/n9u0Q==
X-Google-Smtp-Source: AGHT+IGx6+5Bc1ifsLbmRzddkUuUz7VmSth4MGKr4uN37BTcpZWHsIDbkduizmOilZWTU/0P9JvJGw==
X-Received: by 2002:a05:6214:1d25:b0:6e8:9086:261 with SMTP id
 6a1803df08f44-6eaea996d8dmr57564566d6.3.1741983976790; 
 Fri, 14 Mar 2025 13:26:16 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade234ba8sm27894146d6.37.2025.03.14.13.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 13:26:15 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:26:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/6] airoha: Add initial support AN7581
Message-ID: <20250314202611.GF2640854@bill-the-cat>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VhFzxbBB255Z6PwP"
Content-Disposition: inline
In-Reply-To: <20250314185941.27834-1-ansuelsmth@gmail.com>
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


--VhFzxbBB255Z6PwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 07:59:20PM +0100, Christian Marangi wrote:
`
> This little series adds initial support for Airoha AN7581 SoC.
>=20
> With the help of some backport patch, this use OF_UPSTREAM
> directly.
>=20
> Posting this to have the targer and the very basic driver.
>=20
> Ethernet, SNAND and eMMC support is already ready downstream
> and will be posted shortly after this gets approved.
>=20
> Having the first driver ready permits to separately push
> dedicate series for SNAND, eMMC and Ethrnet as they all depends
> on basic support of clock and reset and nothing else.
>=20
> Changes v2:
> - Use OF_UPSTREAM directly
> - Backport some patch for OF_UPSTREAM
> - Make use of u-boot.dtsi files
> - Fix defconfig
> - Use pattern for MAINTAINERS file
> - Correctly handle SYS_BOARD/SYS_CONFIG_NAME
> - Drop config for header file

This generally looks good, thanks.

--=20
Tom

--VhFzxbBB255Z6PwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUkNgACgkQFHw5/5Y0
tyxA0AwAiLgOYNop4m6yh67H9apRJinDZ30PV11okBBxWvh8lNNkNs9Hnpv89LCh
b0j39EAx6BU8AVRtpdMXI6tlSB2YeYUvwrR0BU4IQCdm6nMLpMo2WAxQMqWv7gvM
v5aPhucmo+TSMrSMLwKjCaGD5YdS/sJI+bM3Y5LtUpxjQ5vSDf84bkSJdoIwRK2W
vV2bV2HqxiMxdNSCYXo3rnGSHspi9/VWR6dtwa7Zk19hwE9fHBePzqjryCZm/xWX
6pqIlYkiwK082+pxAJ2MLAbxZG5ZQ7rPM9BbXUf4FXjMzEt63HI4kHE0Aml0+AQn
OgJFAHf09PWkp03HVBU1q8yqcSDMtqJHIWViZ2K6q8GfWBg3zwtUUGvY1QBluqQs
PST12uOaNz0C3s5SKyGjCNpSljBOtgeLZyfGMbYxdUoC3JRauLhOKp756UMuTJm8
YZ4afK2Of4ltTSlVzf9h2oys2/oZ9wMPXj1TKZwXruc2t6fYE7SqKu7co24gQNTP
t3XAYplY
=P77V
-----END PGP SIGNATURE-----

--VhFzxbBB255Z6PwP--
