Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC4CF8FA88
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B23583FFA;
	Tue, 21 Apr 2026 17:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k2ht3NX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C313840D8; Tue, 21 Apr 2026 17:03:37 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20A783FFA
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-479d4df9035so1191495b6e.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776783813; x=1777388613; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rDSgEO+03QQeupefVK3spukJV3t/qDmEhVfjuxhzjMs=;
 b=k2ht3NX160bfuW4KTJJpa69OyJtx6bACNViKJ29spkUkB1n9r8au5O4wNzLze2QhFa
 3umQGCzg4L2LVVdjsVk6Xe91hDooDhMdIqPNVcAGD9IPOJo7Et06q/6sHoMjFcffgX2B
 eCGNrFiKmqGqgRBxwgd3Ibe6RWzD9am2zrx5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776783813; x=1777388613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDSgEO+03QQeupefVK3spukJV3t/qDmEhVfjuxhzjMs=;
 b=f0yuRjmHYg5XuHyaBF+ivkTwql1lCFAersFd3Bg7r/6mwqt2lVgq5gxiPgHg2fguLb
 cjLPKOmfNvy1Gyw9vCNmYqp2PAWZxag5zMd2vjGPwtel2qCpZgVXDW9BH+ozWtvUvSi7
 xIjJEwZgwjq/nrQ7HMzXtajqEYOpz0xYT5LC9IaLe+8F5N0g4jZpF7/YqX4SZbfAS+1S
 rvoz41kjMUY0JwRcnD9O6qXw0uBvvloft9jS9ostqylQcD48qdL9i85Z+fShwO83wIk3
 r1x6B0xr6Youyfkifa14Jt4aBsGlrzFL8sgkDvVSgjnYnRoUk6E7AiQQ2cuAL3o9cEf9
 mpdw==
X-Gm-Message-State: AOJu0YyS3IbsHUclCj1g+JJSZ4TmYJ1VdxIP+7S0oklqKCrmtHkQu03i
 w7VlOOO5RLlEUx6fwtXnP6IIfjbWIvAgsKk/O3Nyommrjoz5rGZbPwVsxaL5MpmKiNQ=
X-Gm-Gg: AeBDieuexbYc/bZrJ5xZVIsze0aSpZ8ljYE5S27Ci2olzQ/4BO+01CrtAdmI53snpne
 0au7A3jLhJxsOCfOgaxp3WIb8hPHOjp98ML2qVg4hJRWL9LmzdtRtS2auZdFqWxHbPHATs4rWE3
 WLMlPhmh5oeoPJWvshJBCsrmF2rqDONjz/P+9d8rMVd24T5c54Sm9DtmUkRp4f9CSOMqLMdTFWk
 tb2bJ0ahjZSOCcwE4m3c61P//gg3v6A0zMNIxiW4EzWCZVx5QYUiESuwKqf2U4L79vBCQnNoLS9
 sVGVF1o359dso/ejR5yXPBJCvka1iMz/zGjaB2Dw26742EoX9pfL8zyWVD4RyjiVe/KG4S5ZYw3
 NrbzcoGH8xVCxyPQ/TzdSdLveMTxT0/P5sMWGJch8DoTRxaMzN9V/wF24HmjP5UyWourtCeOM+n
 xI1/MYyll2DJMoqxLlT9h0GxI0Psrkqt+2Wx0+5EOeNNCp33OLDpEyzf52+cKQWvvABe+m3z4I+
 pS7Yz3zDCmTCwHXjHdhkJUgiCPqptUGfHGjQGqeZ2TUVORR/qXBtQS8iZWecA==
X-Received: by 2002:a05:6808:3a06:b0:45f:103c:2483 with SMTP id
 5614622812f47-4799c05e9d1mr8902919b6e.23.1776783809312; 
 Tue, 21 Apr 2026 08:03:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-479a0391d45sm8864764b6e.17.2026.04.21.08.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:03:28 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:03:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 1/6] bloblist: add blob type for DT overlay
Message-ID: <20260421150323.GB3036003@bill-the-cat>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
 <20250718141621.3147633-2-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iGFuHsDGOS4KbcU6"
Content-Disposition: inline
In-Reply-To: <20250718141621.3147633-2-raymond.mao@linaro.org>
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


--iGFuHsDGOS4KbcU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 07:16:14AM -0700, Raymond Mao wrote:

> Add blob type for DT overlay according to the update of Firmware
> Handoff spec[1].
> Add an inline header to represent the 'subtype' in a DT overlay
> blob payload.
>=20
> [1] Add Transfer Entry for Devicetree Overlay
> https://github.com/FirmwareHandoff/firmware_handoff/pull/74
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--iGFuHsDGOS4KbcU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeeRuwAKCRAr4qD1Cr/k
Ctk8AP9UySB/OiBejgcLGDQutm63ywvDwd/UL/IPswO9Z4V0hgEA/NWQzJ1FR0A1
r1cfrtZb9cLeb+uCqm+cdFAIFYlotAg=
=rCbf
-----END PGP SIGNATURE-----

--iGFuHsDGOS4KbcU6--
