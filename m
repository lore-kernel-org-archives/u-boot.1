Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2C5C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 17:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C51780843;
	Mon, 17 Feb 2025 18:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ijyXA3Lf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC4F809A4; Mon, 17 Feb 2025 18:15:11 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 483E18083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 18:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22113560c57so33288745ad.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 09:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739812506; x=1740417306; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d6w6SrLfSq/BmPHBzE73HkAlQRW4hXvADKDcTrFfKOM=;
 b=ijyXA3LfO4Bij8sy9XT+fo/Mhd9Y/fFtk8HDGEBMjMq2kMl10WMnMmwcaTYYpmDa8E
 d45CIcM05MkbOYsNMXuwgbnfCz9IwrzOTnVss4evqAqXjF9fvkoUGFN4jII0sdtmU8tg
 xBH1FmsJaa3slNYjBq/QAFxrNw7Yz1/xY36mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739812506; x=1740417306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6w6SrLfSq/BmPHBzE73HkAlQRW4hXvADKDcTrFfKOM=;
 b=jXrBxVPgRnYOquFy6g8p8U+/+XPxjlNA47QsWz7GST4SOUSMoItrK7IsR4HBGX6Xls
 2xbNWISSJA4FNRZ4igUqWZUEHn7o8RKb6e+pokTHm/XG3DXJl51f5bTuzUmr/V5zh3Fu
 RX8U/1gbd+32ZqO8Wvx4UmYWasmssAL1vHeaRtbj+FjeT9jrkxCfu0nQjoWbAOuvLZcH
 ytnGtKezWXIKXa1Im/oSvRKsQeQAoudqCKBwzvir030hPmQam8/Ie5PizNpgAsilQaeS
 KlVCU5U4I9IwGOclVyNl9zIwAi5kyLFOEX+wYbrRR5Cx2XrUQeU7/cgM+XJPnkABpEnC
 OH6A==
X-Gm-Message-State: AOJu0Yyfz91Z/8heyOWyXAQWC7DYjT1Yg5I/Wbbs9EeTdzyAIIzY//KJ
 2Sa1W3FG4H1xPSxlOpYOR3KYvylfUq6cyyCXXpa7I3GlA+8h7kEJEw+ZxfVLi6Y=
X-Gm-Gg: ASbGncvs14mExT6Qat57rVXq2M0K9x3Dcp+tzcgjABqnZYHBWrzXpzaeNSNgBjEIccD
 QNSmnA1XNq9hf7LFjCl+9PNx+mRi1QSpSrrec1ZfcAFmXYLDLvFconWv/0E3O8TYRbrO+LVcx8n
 ebaNhL8SSxVSaL/fi9KuuNs8HDOx8gaUT2EG4nFrGLpTHoDgXqOe8TJKDuH3oZuFpfOIMo+8p0W
 e2xbBxWeKSW5P0i4yLLWyYh9sfmUFQ2UUQOBZLJ3HSYjuq/n2hWyLEGXxrueX8RMEsnDfLMbqOG
 2OQewBxgdCYt2Q==
X-Google-Smtp-Source: AGHT+IGntBBVM0UwMj1HCHAydJTEcS2U+WFc0IoSM5rAQsO5W2p+q4+fm6L0nLW7t29KYiErrQoojw==
X-Received: by 2002:a05:6a21:7783:b0:1ee:c390:58ac with SMTP id
 adf61e73a8af0-1eec3905c33mr1114179637.34.1739812506665; 
 Mon, 17 Feb 2025 09:15:06 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732427801a8sm8369945b3a.167.2025.02.17.09.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 09:15:06 -0800 (PST)
Date: Mon, 17 Feb 2025 11:15:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huang Jianan <jnhuang95@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Julien Masson <jmasson@baylibre.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Richard Weinberger <richard@nod.at>, Roger Knecht <rknecht@pm.me>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, Weizhao Ouyang <o451686892@gmail.com>,
 William Zhang <william.zhang@broadcom.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2 0/6] test: A few quality-of-life improvements
Message-ID: <20250217171500.GA329899@bill-the-cat>
References: <20250209160725.1054845-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QQUigDzOXZl6qp8x"
Content-Disposition: inline
In-Reply-To: <20250209160725.1054845-1-sjg@chromium.org>
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


--QQUigDzOXZl6qp8x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 09:07:13AM -0700, Simon Glass wrote:

> This little series includes a few patches to make it easier to work with
> the Python tests, by shortening identifiers and renaming the 'console'
> fixture to reflect its role as the top-level fixture.
>=20
> It also adds a command to fix testing on samus_tpl
>=20
> This series is based on the previous 'test' series[1]
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D441124

Please note that while the prerequisite series is applied, this does not
apply to u-boot/next and needs to be rebased, thanks.

--=20
Tom

--QQUigDzOXZl6qp8x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezbo0ACgkQFHw5/5Y0
tyyJ6gv+KIRlWAvzxzlpdJoc/BBYr55MIVR/Ckm9FGX93GzTSJ0LHc4awpgKKYWz
qFu6XBX8B998itLHq+s7XL99Ab57qPqUDv1Sb308pKYlvDS+9wClvYFeOggfdZEz
0LrBy47xcox/0x63JePzxhwpCHXMnoN9iLXqYgNNU1456h/h/RmZG/qKnrfyY8M/
Tn5IZIdQIakowAEeHG+FJk/Y6TxMNBgl3kZJVyKC/wlqdkVf87Bgu5gjOxc9wgM4
HB+VPHabEBo04KJ7+A+naZer/PRU1o7+PWaZRnJiEo2UjQO++jX/mZzHySvbE9vI
2YqI5aiTesbJ/FJMAhKNypTnaKbzGxOuSMBtRrJ6zPfwV6C3Dm8CwCfuZk6LY6zs
F/qGSc39eWKCO2seGpcDbEJMoS6BGup3qXz9C8/6qgrHzkEUK2L5a1fodpw3lh6f
gjuhZniaWyeMfS9Z+XzuiAe9bXFzUaHv21YALCzxqQRUaNOTvOsVNIio8rlR5goy
jSftsyIJ
=IB7t
-----END PGP SIGNATURE-----

--QQUigDzOXZl6qp8x--
