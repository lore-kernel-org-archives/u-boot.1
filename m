Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38FEEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E91D86467;
	Wed, 23 Aug 2023 16:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qmj7jChD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF44F864AD; Wed, 23 Aug 2023 16:48:38 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25468645E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d678b44d1f3so7691049276.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692802115; x=1693406915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tke4RBLr5WF7N/aR2R5PnBury5XcPi0jt+cxQCzG0Vs=;
 b=qmj7jChD5ajpbDtp4t0XT96Kd6R/iCEkCC4VZa+27givPzS7wq1UW56vYLPp7qLKcA
 Q2ChhWu1Wd/6KMw4oRYigS9RIfHKF3Uqta3IqvFttMFM2CwosfiUSerRhmR7J1SIhVmu
 kH591cOa3l8iHOcFqxWRM7NWHnz1+DSE+QP7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802115; x=1693406915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tke4RBLr5WF7N/aR2R5PnBury5XcPi0jt+cxQCzG0Vs=;
 b=bbMUPp3ytUI3gTF48OaN5LCidxjP7x5H0bkleVA6vgFUGUpuzEfdnRB1v/MKSIuECW
 8lQCn8sBjRQqAZFXcO7/RAU92mm3McEfdiBvTXUptu+50VVhX69PRcBMwru1/Y5/0X6A
 1nNBrCbefYbCbfXgzXdGYvABbE8IiJ9T2CrKDzaSwYF6xrzdafbRZCaBvmXCIKB5MXYA
 yA0Fsul7GigbPn/UBErGainehaNHujVMP9yrSv6hnkl1Jgt8/wYr6fQlelYWOrhZe+Jl
 ymD0YNIAN1owZK2CAL4UWa765XdnsWJD8uFESp9U2nofQ4QP2tZ7CYFV/Vp7za/NiT7G
 9dtg==
X-Gm-Message-State: AOJu0YyACHx6VaDA3zfIOedpAQFCNrhRoVvvqJjTFq3rZG+HnaskOBuI
 fhQNv/ngG4b9GYUV0f83w6eb9pMzLKZdrdJaPgSvpA==
X-Google-Smtp-Source: AGHT+IF40XqTOJZt5oOly9BtatDiMB2amsmErahvdBE0mwg96b4gdhWwyKdWtR3PGMj8pa7PqwBG1A==
X-Received: by 2002:a0d:e897:0:b0:589:f9c3:8b2e with SMTP id
 r145-20020a0de897000000b00589f9c38b2emr12440495ywe.20.1692801784567; 
 Wed, 23 Aug 2023 07:43:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a814816000000b005922c29c025sm1372487ywa.108.2023.08.23.07.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:43:04 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:43:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul Barker <paul.barker@sancloud.com>,
 Roger Quadros <rogerq@kernel.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v2] spl: watchdog: introduce SPL_HW_WATCHDOG
Message-ID: <20230823144301.GH3953269@bill-the-cat>
References: <20230823120021.50146-1-oleksandr.suvorov@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EnIeOuhBqNA5IEox"
Content-Disposition: inline
In-Reply-To: <20230823120021.50146-1-oleksandr.suvorov@foundries.io>
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


--EnIeOuhBqNA5IEox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 03:00:14PM +0300, Oleksandr Suvorov wrote:

> Add SPL_HW_WATCHDOG Kconfig symbol which can be used to enable
> non-WDT hardware watchdog in SPL.
>=20
> Co-developed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> ---
>=20
> Changes in v2:
> - remove mistakenly included unwanted changes
>=20
>  common/spl/Kconfig        | 1 -
>  drivers/Makefile          | 1 +
>  drivers/sysreset/Kconfig  | 6 ++++++
>  drivers/sysreset/Makefile | 2 +-
>  drivers/watchdog/Kconfig  | 4 ++++
>  5 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index c5dd476db58..07d9dac29bd 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1351,7 +1351,6 @@ config SPL_THERMAL
> =20
>  config SPL_WATCHDOG
>  	bool "Support watchdog drivers"
> -	imply SPL_WDT if !HW_WATCHDOG

Taking out an imply here probably breaks or at least changes boards.
What exactly are the conditions you need to change  here?

--=20
Tom

--EnIeOuhBqNA5IEox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGvUACgkQFHw5/5Y0
tyxaYgwAlF3XDT5/BQAqIXYPGdpnV9n8n6noXtk2iRLQ8cHVkIPHZ+w80TuaeQpI
hxupgz8vFHtvUYulrieW838cxeLAJ72KmnUOUhQ0PBUj19bKorHhEvEW8LV6xf0Z
p8uMQI/xXnYXQWpmMKBA0XvCHw+f8CJ1BNhbzbrkNsFhZv/+bfZPKfOoCjCk3knK
2aWlUh+ZD92017bRfLOQ1SoSNW1/0DkHoXiVSmbI/A7rIAzIG0F5yngu54Pq6yCi
wLRviiGr6WSnDQoTHBUv4S/rkeLXS//8qOwUqSe+LJyXsjZC4a6xyPtLU9wId1zi
+fBSo3VbmTsUMPkXLd7fZxHtAZHFWMXl6Sa4SKBfjKhLozekFixTkALSk7Qjzco2
tP7MmL3LvWgx3njYoANo0nNYp1Lr3R7/d2Bxp5iVwpHWOGinWIcO3csVVDD70Jic
MgLhi7jmj7OdnBinqwwlZMiWuvsvAlMoA9VC+g/zT4ucqx5IgtexHdW9HCmuRUuA
S6pihQAv
=nioS
-----END PGP SIGNATURE-----

--EnIeOuhBqNA5IEox--
