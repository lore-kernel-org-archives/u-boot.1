Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B534C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 15:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEAB388701;
	Mon,  8 Jul 2024 17:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EAWex3ww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998EC887D3; Mon,  8 Jul 2024 17:48:26 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A628869A
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 17:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5c6775ea6a3so691534eaf.3
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720453703; x=1721058503; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7K2NzAbK62zAWMvmyHzJhB1898ebPedtE0hz51I0Uq8=;
 b=EAWex3wwPdlmRKZ2sMSVVVsgKb3Ard06YNsWijNxcJndGm5GTiuH/dkDGb+VXhE17X
 ucL14KGP3nDqvx/yS/kAapQ0twQdOJNtWIixz3QyAYEI6ltH2XoByTDsx9TEuK3hYshH
 4ZZ0aaLi+1IUrS5+61SIVHw+tNi1cKn15vP6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720453703; x=1721058503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7K2NzAbK62zAWMvmyHzJhB1898ebPedtE0hz51I0Uq8=;
 b=mdwWZzkPno3+ftsquokNCurN6Z9qtM1I9HdacPjXNthwHWbGeEdummCqVhp/YojuL4
 6AyYZp0kIkMafen6o61tLpCZik5kvxxexMixRDHqMPu3Po/gCKKCh+VH3ScJIxWtGc2f
 gx8qVHXoQmcFwM1hHfsIF/ht/FOvLr/rsWWxyBFMFFYag/OybIRTDloktePPmYOSyfDG
 2hOhKvFGgBNnkJcoJ4PmgJZyXPal/h8chGfozHCCQFmyOGT9J58409qcy/sUR1lVPWXR
 N/nmIzBya172kQrIp6PbMY4sEhCTf5/9+D9UFmwUAMznSIGhDYFSXann+Q8Gs+lS4npW
 tCiQ==
X-Gm-Message-State: AOJu0Yw1ua8xqsKj8xk5KVWf6rl3L0uwweoQy7AvSJyK2jrqEr8N5Taf
 WW2vWi/ErZnGf/1H4qwuhGY/v6Z+QMgdz7BD2Juti3qm9TAPkQ4Qr8bfC2BV+GbrEZUZLMqrEj6
 PbLc=
X-Google-Smtp-Source: AGHT+IFAOwJ7IooHh9rr+u/4l9e00G5wByy0lroeFagGWkoNvPl16dcc7z7+BKWikJbXuDjtHIqECA==
X-Received: by 2002:a4a:5501:0:b0:5c6:8458:5743 with SMTP id
 006d021491bc7-5c684586215mr2053068eaf.1.1720453703185; 
 Mon, 08 Jul 2024 08:48:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c68cd72bc2sm16837eaf.5.2024.07.08.08.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 08:48:22 -0700 (PDT)
Date: Mon, 8 Jul 2024 09:48:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Scaria Kochidanadu <s-kochidanadu@ti.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, mkorpershoek@baylibre.com,
 abdellatif.elkhlifi@arm.com, sumit.garg@linaro.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 semen.protsenko@linaro.org, marek.vasut+renesas@mailbox.org,
 nathan.morrison@timesys.com, devarsht@ti.com, j-luthra@ti.com,
 vigneshr@ti.com, praneeth@ti.com, nm@ti.com, khasim@ti.com,
 rogerq@kernel.org, francesco.dolcini@toradex.com, afd@ti.com,
 jan.kiszka@siemens.com
Subject: Re: [PATCH 4/6] arm: dts: k3-am625-sk-u-boot.dtsi: Add sound driver
 nodes
Message-ID: <20240708154820.GF38804@bill-the-cat>
References: <20240708075207.37207-1-s-kochidanadu@ti.com>
 <20240708075207.37207-5-s-kochidanadu@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XEXBaJxfE9qCIg/J"
Content-Disposition: inline
In-Reply-To: <20240708075207.37207-5-s-kochidanadu@ti.com>
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


--XEXBaJxfE9qCIg/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 01:22:05PM +0530, Scaria Kochidanadu wrote:

> Update the am625-sk-u-boot device tree to incorporate the sound card and
> sound drivers: MCASP and TLV320AIC3106 Codec
>=20
> Signed-off-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
> ---
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 85 ++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)

Where's all of this in the upstream dts?

--=20
Tom

--XEXBaJxfE9qCIg/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaMCkQACgkQFHw5/5Y0
tyy3xAv/WO8qgZq3RpOpwhnrlPZa5BsIRnBXtclw/1NimWaAS84ZoZOJkS2uRudh
9mRCgYczD3x5dExWjhF3VjxtKAM+I2+gYfuE8T8nxVsa21tUexR+f55PjJRsFc6+
Yn5jX488qz7JkjaLc/9W5MzROCTi/JWdI3izKjbYL95OxWCzHDWdPVN43XH+D235
kudFA872rDOMlKoHM9Enqw/zE6X0+IAVgk6erkvnwtr1WaGUHVm1tLd9JA4GmNxp
xWieT4nk6au6HqzyDNtlp9/SXPVnpOeMahadwlFGxrZIvbLSt9UtMqBTAdatVOt8
C7ceSn4wuoRdDT7NddakweOCqHZt5xjoc0vCSlSh7MLyGmLL4QkxT7VQh+6ucJCn
bYOwZl2WwU8b+avHmmOlMKpC4oxypPzGb1h9rlPRarFCo4j0FJqmY2s9EbCmjxtV
cdHxBk2mtOfXH5ygAcSCafbgeHrajW0BugyVEPMBDrb5PXIyyfF7bdyjDizrOlit
QWwX8TKh
=TWD4
-----END PGP SIGNATURE-----

--XEXBaJxfE9qCIg/J--
