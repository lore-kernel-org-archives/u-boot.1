Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE7ED374A1
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 21:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B78A84218;
	Fri,  5 Dec 2025 22:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mRudF7kN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E05958421A; Fri,  5 Dec 2025 22:04:15 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31CE8420D
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 22:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3e3dac349easo2189637fac.2
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 13:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764968652; x=1765573452; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pm20G7mqMlhXr8DLPllPWgNqnbSfTVBzfsBStnqz5YM=;
 b=mRudF7kNPpm3EMy6wywZ+kir+yS/gTGE0eMIZgG6blxvDElnoXFUdlVMs3946Xkrx6
 IFv/fU48RQERYqHypfOUb1SNFSkiQeDpzZs2AMu5ZXj0S3E14giu17knovAVR3A13Z4S
 Rw9jDPDfAt+Skk6DHpB8gZGzwBz6FY3pZKbRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764968652; x=1765573452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pm20G7mqMlhXr8DLPllPWgNqnbSfTVBzfsBStnqz5YM=;
 b=PPYdjGbch3kUcMdhdtrztSoiRhOFqdEmQN+IBJz7XgDVyduXq/0lN4sgxfKLeb0fZF
 QEUi4FHZxDhlV3Wved3hU2TBfLExwgtEpZkH9c2N0Elsi7Mq20CrDmnu97/4X1UcuOdV
 zZmb82NZw2h08PfAmCaaXUBntxwMGJEHQmuQFATuAi/cqGbYb4mhIahlifKFCFZpxXUz
 elvYBK7FrsNlTNYIjlEU+PQua1S0103Sroe2qW2ESoJNn8iBdiCva0pLkecSNH6X5sRv
 PV5dKPxi0OhZCMResCzd0kntUPyB3AS0TMjpZL8lvp5+xECrP6+FywbOjeTxVTrpW1Ew
 nCXQ==
X-Gm-Message-State: AOJu0Yx/s/02bdQJq3qCCYFTYwarqW4xmSrMbeWxuzt0jsMMTqvV1Gny
 aYUJ/XOKfKO60r4gAvRg5PrGEdTtZuKP/I+/XF1TeU+UQgHHlC/xf/fULJoC3AB+ReI=
X-Gm-Gg: ASbGnct4Sl2SR2C3ae8yYHArwd8L3M4lOIkZe97UuMRgPtbpuQhkpnP0ZjUt/W0hDB0
 7v2Cr02q1FERtiuHwUtU0PsSCyZjmrA4wLRJYXCfxjmzFqgm13FygU8KKFUIFxkNNLibcU9jKPJ
 f8OrLoDKMjInpwKrVHZP5TWF3PF1ksU/1LWxgmA4V4dCXSZGINTS5KG9+pxn4XuvQ7JLB7349E8
 t29yxwrUYwBmq0n41Xc5CAevCHqWLMNslhMO0eq7/UbCYSRoKKSmjha2z5Y+WQXqGvA5nuPqtxs
 lm84XN40tgeWyKp8Z0VVDqKqcp7/xAkNVR+Kxw/vMHH009ZVI6LeCh1lnO4wvEn0XPo2bP6uxtH
 +U4TiVW7uUYmcKfUJ7bdWU1r4q/MukMZuJONsxFRYxOP9fhajoyAuzNvVpkRYMve8SwAW4k5gpx
 3B9I/cV7mTG41osPHC8VjNvdScPWgyE30nOCV2L0uvdRWYerstOw==
X-Google-Smtp-Source: AGHT+IG9KZX9XoYFFtBad/aLRG0mUeMswnSguZtSORRMfrqSj/UKgns23hEYbvY2/lVVwNPaAby9Tw==
X-Received: by 2002:a05:6820:81c9:b0:659:9a49:8dde with SMTP id
 006d021491bc7-6599a8ea4b3mr268608eaf.32.1764968652342; 
 Fri, 05 Dec 2025 13:04:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef5e74fsm2802837eaf.17.2025.12.05.13.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 13:04:11 -0800 (PST)
Date: Fri, 5 Dec 2025 15:04:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@nabladev.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 1/4] corvus: remove green led support
Message-ID: <20251205210409.GL303283@bill-the-cat>
References: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
 <20251119-corvus-led-red-green-v1-1-ce86b8d59dfc@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BmNrA2R58PbLI2eg"
Content-Disposition: inline
In-Reply-To: <20251119-corvus-led-red-green-v1-1-ce86b8d59dfc@cherry.de>
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


--BmNrA2R58PbLI2eg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 06:01:12PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> green_led_on and green_led_off are only called by the legacy LED command
> (CONFIG_LED_STATUS_CMD) when CONFIG_LED_STATUS_GREEN is enabled, both of
> which aren't enabled for corvus, so let's simply remove it as it's dead
> code.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> Reviewed-by: Heiko Schocher <hs@nabladev.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--BmNrA2R58PbLI2eg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTNIwgAKCRAr4qD1Cr/k
Cm0nAPsEWoQNZTfWMY8uO+BsvM9JeWqlsWTRYwx8fpSbV2Y+5AD8DVuGZA6hvVLc
erewpUUnSCDtV+TzJJ6QEOzRROqATwI=
=q0K/
-----END PGP SIGNATURE-----

--BmNrA2R58PbLI2eg--
