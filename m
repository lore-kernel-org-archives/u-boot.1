Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D76C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 14:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B3387AFD;
	Wed, 25 Oct 2023 16:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TLKVCb7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 946E187AC3; Wed, 25 Oct 2023 15:40:14 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD0587AC4
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-66d1ef93284so34808146d6.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698241207; x=1698846007; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MO8a1T6FVdJXeGY8Ehy4160Pf8XCg6giZSJMJH94n9E=;
 b=TLKVCb7taYsO//fVdPzgFo6Dzo/Q1m4AYjq4G/eVy48HOWmAw/tJrZdE4muMzCPzpA
 EMGhoh7aKEB7pxiOEABwZ2fWu0vH1zXyf8VA1TyQbWNiKdbjLjC9JJ5NRsDy8hw2i7ms
 Cv2PTS5hs72XuiIrImCHLkCNW8U/rUihqKcwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241207; x=1698846007;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MO8a1T6FVdJXeGY8Ehy4160Pf8XCg6giZSJMJH94n9E=;
 b=DLWkW00SY5e8Gw09cwMR31YFKDDG58IsQdKmPy02p3yBooASLiCtYGL+PxmbQ7huYa
 0krBnTJJR5TR0j+XMarV0wX9zOk6EohXfxyvhAElO+fPOOjUJiuGIuMJ32d6IRgrjbvU
 +5yuRU2OAuAe7jRd584QTT3njMjlgB2IDGagBoxNSzxH5DCBAuXEqQuMOgIF76n4TJf4
 /TFhggcwH6Pt6kueFwkrNfmKDkk0+42zZNE97qBT8l5pDl4BKFMNw28qIm9tSw4ceqor
 hSDOhngDE9P+xcxg189lMriIgmGwltQCfm6tQpC8ni9EbKWZUf6gbZGoHFtwqH4pVkqP
 hY+A==
X-Gm-Message-State: AOJu0Yw48NHBcQduVhKw4MHL2er7bqpJWMArqsyPnvpnNjgOJ2eDoC/W
 3ltkkqfCR2uG6LVAAYX4DvZ98A==
X-Google-Smtp-Source: AGHT+IH0kz8EinM8rWRewD4QprCDCLSS5DFxn4RvgPPhnpWME+m5DbdTCma1Gijfom7CyaXJZm1cpw==
X-Received: by 2002:a05:6214:2121:b0:66d:48e4:9928 with SMTP id
 r1-20020a056214212100b0066d48e49928mr20153280qvc.12.1698241207044; 
 Wed, 25 Oct 2023 06:40:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 dg3-20020a056214084300b00656373f9c30sm4417847qvb.75.2023.10.25.06.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 06:40:06 -0700 (PDT)
Date: Wed, 25 Oct 2023 09:40:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, takahiro.akashi@linaro.org,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chris Packham <judge.packham@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Huan Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>,
 Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Qu Wenruo <wqu@suse.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rick Chen <rick@andestech.com>, Roger Knecht <rknecht@pm.me>,
 Roger Quadros <rogerq@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Tom Warren <twarren@nvidia.com>, Vignesh R <vigneshr@ti.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH] Kconfig: Remove all default n/no options
Message-ID: <20231025134002.GM496310@bill-the-cat>
References: <e3bb5522913c8a917feb7d6309a693f7ee5dbe25.1698218728.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9c9vUdqnXvKcQCCf"
Content-Disposition: inline
In-Reply-To: <e3bb5522913c8a917feb7d6309a693f7ee5dbe25.1698218728.git.michal.simek@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 25 Oct 2023 16:20:41 +0200
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


--9c9vUdqnXvKcQCCf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

:n Wed, Oct 25, 2023 at 09:25:37AM +0200, Michal Simek wrote:
> Similar change was done by commit b4c2c151b14b ("Kconfig: Remove all

> default n/no options") and again sync is required.
>=20
> default n/no doesn't need to be specified. It is default option anyway.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Thanks.  It would be good to add something to checkpatch.pl for this,
and it would be appropriate to do it outside of the u-boot specific
checks I think.  A similar patch could be done for the kernel as I see
519 instances there currently.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--9c9vUdqnXvKcQCCf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5GrIACgkQFHw5/5Y0
tyy4Gwv8DVZQwSQRgZSIeNYJciCBte4yGuesh6OUd2lq2F3adnCg6XCxP51Tm0Qb
fuIF6MXctJ7Mge1Ag3DX9RCb93cvwVzZ8i7yxar+MQyzcV8j1XZ4GaqY0ri4v3C+
Glist3wZuOOTZoc8q+/pg5m4WO4YFy21zahsVxXssGeZLdJnogBfm3u08kE+BluF
lpYAzHuO1/CYTmF9i9sghYTOqxwenzogV8slPJsMANkt/RtHbTl0x2vzmgtVzBK4
I83ZMH/RO58f5UxjmCUtuI/tyujCN02RlxfT8h/VCJxqMIkkh6lszqWvYxSKr8oZ
81RoxSPK5N5OTj7oePifpUFsYhiRwn3ukeCnFuFjMwxiXRy3Okma3BFlCwhRQxfM
K5bp7N2Cz2rzN0y747BkWa0Z/wKnbxloveW8o+gYwrEyBhrpLxzo99uRHNcYoVO8
JN21sJ88t+2RVdXjBrWrS3tAnCAd1jAQK+IAiJNuGcx79Mk6GxCOYLarhHjS7oap
ApXqhAZz
=Mel9
-----END PGP SIGNATURE-----

--9c9vUdqnXvKcQCCf--
