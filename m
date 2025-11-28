Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E34D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A90C83AB7;
	Fri, 28 Nov 2025 17:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yl0/VtDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B8188457A; Fri, 28 Nov 2025 15:30:14 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6059584564
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 15:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3e0e4601faeso1082884fac.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764340205; x=1764945005; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=48+HDzWhFzbRz/7v4rERQdSj8f+0MJiXlUZwduy9iIM=;
 b=Yl0/VtDCQCDfE8qgk5yxhKyrZJvSJsXLUJFQXoE3/A3ohPdYScqbjjhllKxPlmNMZK
 67H3p4dY7f1MB81XmDyIjZ0LpX8/MBO8wFsbZQLGnLqkE1+GbMY7M94/tiWXf5BlHJue
 HQ6gtItAXgGMrxFmvSGQIGf8krtQ2g2k4G/fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764340205; x=1764945005;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48+HDzWhFzbRz/7v4rERQdSj8f+0MJiXlUZwduy9iIM=;
 b=noRSt0U70fy6XWEvJ2S44nq0yb2pWaZeVV8en59NhYWXGJgd8/UBv2hCJBSwEFHdoi
 oSUMq91DKpkTmeNFYbPA0hbZQrhnEBE4qSPz4Tjy5WhvtfT/7uddKRfeoEo1GBwdHGp+
 HcmI4bt1Z3IJOq6VFoCLMPagtw5IX5xB1b0dq9ALbexuDmcnpZtfK3m7lQVgs4OC8p1j
 e7SbDeFYomqDrILYuQ3qDjk0gclVnisQ6Mqo3M6NkHP+2mT8447uO05q+0TTAo4OBSlB
 Eq3EpUEbknZkj7sG5XdnrCNSjNQ8nVJX3dEfjAdKWUcv9rPMSHUIT+6j/fOPI9Dd6tBN
 +qCA==
X-Gm-Message-State: AOJu0YzOO+w3QOW5M0SEUDpiUW9tLNumKcyJSubREg8VxFD/XgwhPl94
 Sizmwv9y2opWFktP7mwZyDNpgGO+/PDGFa+ljKU/T/xq73vG1u2SpqE7Sfz0nDc7AXR7e4IOvnD
 HVCsrJBk=
X-Gm-Gg: ASbGnctCYl1fo7jyQA9mNLDwwwBArmog1HEvdd4vD+2eoyrSk7b4F77px0i/6YHIE31
 oR0fNT/zjwFqXPjHE4G62iO+QFa/7d3ZCcaINQXssMRfFAFphwJhZTHIumB0BieYS8uvYvxQjr+
 340wGBM5DvuMkElfrnQ+3fqjUb5SLSf0GRYlmnAsab06ceH5e7FB/9AHASY3Qi3XZC6K19zcpJT
 9WWQk+VgaHj5I2nysBDnK8Ez1MyJAH3PStPsTpUjxpaGpREQfj6Xs1e5yAghj02KGR1d6XI3b91
 GbmKY/bW48id7dMpx7c1X0ic3yeMswWyEknmwY4mmTBcKI+49r5HUFbO5xoEJTUE8QDGVejAkWU
 sXkU1FZ/WJ0m8bJ6bfrbMyUXyF6tIuB2TuxM7jw5eyIkBY/fxtIhzWTbPKKekjj6KLHHLDfCHkn
 65dnzpNzzSlRkPdvJG8oo8+FxlF+2eA5VyTer6N7gez99ww2YCmw==
X-Google-Smtp-Source: AGHT+IH22wvas0O5HwdD9hKFQmKpXHrRgKN7eiKwE5U3V863yeVA6CfrrNp6MUq4aGLjtYM4lUa9og==
X-Received: by 2002:a05:6870:3045:b0:3ea:ff22:3ddf with SMTP id
 586e51a60fabf-3ed1fd95f33mr6659851fac.25.1764340205312; 
 Fri, 28 Nov 2025 06:30:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca05aa7sm1836419fac.3.2025.11.28.06.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 06:30:04 -0800 (PST)
Date: Fri, 28 Nov 2025 08:30:01 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 "Andrew F. Davis" <afd@ti.com>,
 Javier =?iso-8859-1?Q?Mart=EDnez?= Canillas <javier@dowhile0.org>,
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@nabladev.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Adam Ford <aford173@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 Thomas Weber <weber@corscience.de>, Enrico Leto <enrico.leto@siemens.com>,
 "Derald D. Woods" <woods.technical@gmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Niel Fourie <lusus@denx.de>, Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Tomas Peterka <atheiste@seznam.cz>, Anurag Dutta <a-dutta@ti.com>,
 Fabio Estevam <festevam@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 1/2] clk: ti: Split common omap2plus functions into new
 symbol
Message-ID: <20251128143001.GA2125796@bill-the-cat>
References: <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-0-d722c79506b2@baylibre.com>
 <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-1-d722c79506b2@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="78GU/lKRf3po8Ihu"
Content-Disposition: inline
In-Reply-To: <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-1-d722c79506b2@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 28 Nov 2025 17:28:20 +0100
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


--78GU/lKRf3po8Ihu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 11:16:59AM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> Create a new symbol for the common clock functions used by some of the
> omap2plus clock drivers. These drivers now select this new symbol when
> they need the functions. Note these common functions are not
> ARCH_OMAP2PLUS specific.
>=20
> Note that the common functions are using regmap, so select it here.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--78GU/lKRf3po8Ihu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSmx5AAKCRAr4qD1Cr/k
CjkJAQCOtR6vyOMqJP/iYr9Dxy7wYfw7jDuChbY4UxrUw0gBdQEA8uCBDrNFgtV4
7r1rjymhJF2LiuQ52MUFghWyOKjMKAE=
=p30A
-----END PGP SIGNATURE-----

--78GU/lKRf3po8Ihu--
