Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2112FC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6046A849F0;
	Tue,  7 Jul 2026 18:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DgVgyia+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1344184A78; Tue,  7 Jul 2026 18:38:01 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07904849B1
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6a354eea06dso750445eaf.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783442278; x=1784047078; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yMlQhc0YiEFel/Rd08L2iWqEycc1zwRAphxA8ilBc3s=;
 b=DgVgyia+I7aaAvzysWZC6Eimk2mUD+sWNJmlWWmL5FIBjkuTt7WLlTGH9wDCriRwmJ
 vbRZKVQApJjT6BTGBsAxJRDH4P5CbJ01NoQXLNzSMCkkSmgPqyk4q1iGteY7SV0wnCc+
 73hoG6ZI8GN3d8zx7X1/9bxe43OEISewuJbac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442278; x=1784047078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMlQhc0YiEFel/Rd08L2iWqEycc1zwRAphxA8ilBc3s=;
 b=HIEBNW8z4GxJkOB2Cv3USIrOcfMFM54DiZQJghjSqOy0j+POGSLUTVsbMVB8EuQ8O5
 9Ad6e9NS0cTFV7WddTPmUk6pTFjTtyhRhnwtG8Ua2RYnnRCwDXHYynnZw/l5Scvq/nmc
 hicIpLMT7vVvQC5Q4ODE4oP1ZhG5zx1NxgPa0vTb0s9pFDFX6WJBZZlXPTlu1EIlq8ja
 GaaSy2OMrIQ0G14PWc15E+xVKZ+zuK0wGwWUvq0eRSI3aPYQOZaUZFAIqME0eJEs+Plb
 PfYhdXfOESNXfG20lW3LlNjsB3cADXPptET0WbHCfyj66LikOvnL3W1U3hrQUJFtlDt0
 tM9g==
X-Gm-Message-State: AOJu0YzdZ51WASaQjwVkZ/OH4EbeZ4oKWnpnjvDuThzG6sR+F+Ra8GcY
 0ZeZcWy6Mpj+Ah4at7UTmyr+uQzlILSws2dY+S6keM+Ft0k80CK/I19ZOwe0fE3QdkE=
X-Gm-Gg: AfdE7ckv+rzKeST6hgZQNQeHG9tOTaeDgP8B6ORpJKZCiE+7yWrrCf8vxFF5YgksYP0
 9/KwYj2klm+o+29MF50On9vH5VR4XhbVybAJ+LvRFZZJgrwF3nbu5qAvRq2UV6X+txE5RBkJWqr
 Y8eFOfzILV9nzqmfcD7WrvQQXi7ZYaHkqjjdOV1gFMhA8b/JMc/n5XSFvxKlVwKSrI+BXsOJUN4
 WmMWdK9BBB1CQB5ADTbJUI5pcGWfOP5v8RG7Wv1CRQo35hjQfbS2K8HGg8bgbyhY6V5Yv+cNVu9
 gJ6TRJBK2JcoeNEDca1QSmo7yOh4ZT72hYWpGulYr+ZbA4sM8WC0H3FKjrBZePg7bA6Y+/Ku2lR
 b/61xRddL01iq/3wiFmjLxjNiRTh7kw1VdfJYRUjHFDcLOolp5TzW42qcFmQgeKSLBXmSzWUW2Z
 pB39VsRfKFMP2k17QZ7v8EuFTtsrIFADX6cK46+wOIvosuuVThlN7vH8a1etAeF7ewWct4pVqlR
 BsBpzbXqBV6HLAgmPg5rB2XGhYyQ4LHHb727g==
X-Received: by 2002:a05:6820:1503:b0:6a3:873:6162 with SMTP id
 006d021491bc7-6a3555304e1mr3532048eaf.39.1783442277766; 
 Tue, 07 Jul 2026 09:37:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1bb17fsm13826737fac.5.2026.07.07.09.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 09:37:57 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:37:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: Re: [PATCH 11/12] MAINTAINERS: remove Philipp Tomsich from ARM
 ROCKCHIP maintainers
Message-ID: <20260707163754.GJ749385@bill-the-cat>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-11-dbc9c696e613@0leil.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1CPsFomdW+qzxPSS"
Content-Disposition: inline
In-Reply-To: <20260707-rk-custodian-v1-11-dbc9c696e613@0leil.net>
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


--1CPsFomdW+qzxPSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 06:09:25PM +0200, Quentin Schulz wrote:

> Philipp hasn't been active for years so we thank Philipp for his work
> over the years and update the MAINTAINERS entry to reflect the reality.
>=20
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>

Yes, thanks Philipp!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1CPsFomdW+qzxPSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak0rXQAKCRAr4qD1Cr/k
CvqoAQCPVxtmFVjEgLROUA0f51dxzz80F8gHtzAiv4jEP1DEQQEA2n3FB6AmdOa2
qVtfrKpVl7pdUsHg0yxFPZFkTfJFZQY=
=S7KS
-----END PGP SIGNATURE-----

--1CPsFomdW+qzxPSS--
