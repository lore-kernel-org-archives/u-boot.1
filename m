Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D398BC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 23:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 593C380D89;
	Mon, 20 Jul 2026 23:34:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eg8BePSUcyk0; Mon, 20 Jul 2026 23:34:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66D9280CAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784590496;
	bh=+F1xvD3zYVWGfgXua1B4QzCtMG9fq0NlNBxBSwoEAxE=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QJAd5BLnQdfYvBVeK64RWa1sMdoIHn1x7lORO+SN7l6qkYRI8aNHm6BDQeajMH1rX
	 /QxNzoPo1hgUIUDCiieKRiW+6KlDDEbW7bxhHNygn2GTxE6SQElEEuk5cdg3DyiWcR
	 XW4m5qtrFYlZiasNhH8q1TuJb+v3sWC4RZ3SHJwoJoXQ4ZmF49DxTAifxgBbLihWTK
	 aPdzAuQNt5Is8+q0xfWJVxQSZ1C9uZ+O/hIlNIJCqqVSh3r9Yc8Gd6x+ecls/ujQR2
	 +XwLR46fmmqA2wARhODMiFRFB2kjc1nNCpbG9O3ddIMk4qm2H8F0c9I3QRH1+xeFOD
	 jLO9xfW5zDKQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66D9280CAB;
	Mon, 20 Jul 2026 23:34:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 826E6132C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7440080B83
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:24:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PCNJKX9r1r7f for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 23:24:22 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 71F5680B28
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71F5680B28
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71F5680B28
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:24:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC4983C14; Tue, 21 Jul 2026 01:24:20 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF0082991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 01:24:16 +0200 (CEST)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-497d3e4460aso4349272b6e.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 16:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784589855; x=1785194655;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+F1xvD3zYVWGfgXua1B4QzCtMG9fq0NlNBxBSwoEAxE=;
 b=sFlxd12qrOgZpLeZIdpqenvsCZu0vN/g3h9oX8Llr9xSHUw8xFpFkb4xxzNiD812Q0
 m/z7SWQ4R3xo7mJJn6e6NpbW/IojN5MGiK4Qs7uiVLRztLO+LaLJEr67/LyM5JGRkkKN
 Ar4f+mCOcNFReMd6BSos5z0OP+AruvsOR8IkHLHjJ4mGueuty44qIqWdznZPlbIn7FcI
 Tr1dkzolgI7D7kLQTkpCsi4PeK0Wx2JBTh9j9sEvncuCxQZS9fP1V9yRQk90DBwCY/sB
 v3kqaPNUfrZlMwdrcPWPR81RKMK2tnNeq5wQpIKYe192jbTO2wYrmv6MJI0Y8OgKp3X5
 Uq0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDIPvGhwhT1fUYb1mnzNKM+7qhqpX1laJtvogimD9DA5GCimLRY4IGbDHg6IzsBYCxZ6De/Ys=@lists.denx.de
X-Gm-Message-State: AOJu0Ywm+wi+8B3U4xX1na4qL7dPjLAkBjBEQ8oVGl6vqEjtdU2/vrhZ
 ++7uv+DVF+kOEamYzySVrn3IxMt7M+nEGzMaeuu/p0KKhrq+XRBPqZhFrsrsGisqqjY=
X-Gm-Gg: AfdE7cm5V0eXWcb32Apfhf8KbnxctIVTeWMUvrB8SNkBwQPTUni2sY0XhoqNtywzmF8
 mV+cGw/mo8ZZ6OCeEspztKJJY40j0PPPqtqkQiCzxE8WkISKSZLWfkt/3poSiZ4CYz0qjqzdhNe
 RCfqwThoduto8c/73UeHvbpQQEYx/H2nB071gFiqeyOFaa946+ii7jL/eYUh/1QANx+l8r128Gw
 SwbbXfYmmqL9bxyy3b0QLzTufd1f4yJn7rPzootjhz/blN4cU0eR+l4+5WKNdBveFOopOFtqJqp
 kuUeYy9KWYvW87aqlO+YviRI909P/CRA/oHfJQWhw3jSW0noFEV7souIll/LKHGRO9QRD80Jc2l
 XmLci9Pfm4x48iaWuvqAxz2PgoAGvMFYkm/ZRBFHIFaXAtrA3kOd7JtHu/rNi4kzP/PYlnxlPGm
 s1MAHAuS0+xTMAlZjNPjFE0kR7kTdISCIyU9G0nQOT2LjkWsTzZwAHDuSXk6RYnu//Hrygb+F2R
 Fhwa4JBhihAsJ6Un9+QFXI9t5ObhAguisizPw==
X-Received: by 2002:a05:6808:1445:b0:492:3ad9:15d9 with SMTP id
 5614622812f47-4a4cf06c64emr7550449b6e.6.1784589855377; 
 Mon, 20 Jul 2026 16:24:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a4d3d4aa0dsm8350460b6e.17.2026.07.20.16.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 16:24:14 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:24:09 -0600
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Simon Glass <sjg@chromium.org>, Thierry Reding <treding@nvidia.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Daniel Golle <daniel@makrotopia.org>,
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michael Walle <mwalle@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 Lukasz Majewski <lukma@denx.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
Subject: Re: [PATCH v5 02/14] crypto: hash: use DM providers from hash command
Message-ID: <20260720232409.GN749385@bill-the-cat>
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-2-3c41f66d4522@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ktBM/SItblSAEpki"
Content-Disposition: inline
In-Reply-To: <20260719-submit-ce-series-v2-v5-2-3c41f66d4522@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 23:34:55 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784589855; x=1785194655; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+F1xvD3zYVWGfgXua1B4QzCtMG9fq0NlNBxBSwoEAxE=;
 b=VY6mUCXMw94Ed9nQBTgFj6wlU30XUW8lzA1+vLBSqyTKVLnEvpVfuZK0DJissvAC7X
 1IJZ6U5573fv17xBNU7mXfDMLBeLKjgbJic6oUzkDmKq+kUegTgxI0nzlPLaUpxvd9cq
 kZY7al8d6lzIrJyu7PpXBpRzVQWgCt0uYgcVU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VY6mUCXM
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VY6mUCXM";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--ktBM/SItblSAEpki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 10:13:46PM -0600, James Hilliard wrote:
> The hash command currently always uses the software implementation for
> the selected algorithm, even when driver-model hash providers are
> available.
>=20
> Add a hash_digest_wd_lookup() helper which probes UCLASS_HASH devices in
> order and uses the first provider supporting the requested algorithm.
> Continue past unavailable providers and unsupported operations, but
> propagate a hard digest failure once a provider accepts the operation.
> Remember probe failures so they are not silently hidden by software
> fallback when no later provider succeeds.
>=20
> Use the helper from the hash command and retain its software fallback
> when no usable provider is present. Add sandbox tests covering provider
> fallback and hard-error propagation.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v3 -> v4:
>   - New patch
>   - Try all registered hash providers instead of only device zero
>   - Add provider-selection and error-propagation tests
>   - Reserve -EINVAL for hard errors
>   - Use -EOPNOTSUPP for unsupported algorithms

Putting new features in an unrelated patch series makes things harder to
merge. I don't know that Andre will be comfortable taking some generic
changes + sunxi support, but he might be. But it's even easier when
something like this is standalone and can be reviewed and picked up on
its own (I'm going to have some size questions about this, once I review
it globally..).

[snip]
> diff --git a/drivers/crypto/hash/hash-uclass.c b/drivers/crypto/hash/hash=
-uclass.c
> index 5d9f1e0d59b..30929412856 100644
> --- a/drivers/crypto/hash/hash-uclass.c
> +++ b/drivers/crypto/hash/hash-uclass.c
> @@ -73,8 +73,8 @@ int hash_digest(struct udevice *dev, enum HASH_ALGO alg=
o,
>  }
> =20
>  int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
> -		   const void *ibuf, const uint32_t ilen,
> -		   void *obuf, uint32_t chunk_sz)
> +			   const void *ibuf, const uint32_t ilen,
> +			   void *obuf, uint32_t chunk_sz)
>  {
>  	struct hash_ops *ops =3D (struct hash_ops *)device_get_ops(dev);
> =20

This isn't correct spacing before, or after? So as part of sending this
standlone this part should just be dropped I believe.

[snip]
> @@ -29,8 +31,26 @@ int hash_digest(struct udevice *dev, enum HASH_ALGO al=
go,
>  		const void *ibuf, const uint32_t ilen,
>  		void *obuf);
>  int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
> -		   const void *ibuf, const uint32_t ilen,
> -		   void *obuf, uint32_t chunk_sz);
> +			   const void *ibuf, const uint32_t ilen,
> +			   void *obuf, uint32_t chunk_sz);

Same here.
--=20
Tom

--ktBM/SItblSAEpki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal6uFQAKCRAr4qD1Cr/k
Ch2DAP9TrIystYOK9v23ylicGQyoWmcYVAuQ08km7Xvg7DtBTAD/axHHH1x3iNxG
j8c7/B3Va9CxLun9a25CJzQzaTptBAk=
=qpDT
-----END PGP SIGNATURE-----

--ktBM/SItblSAEpki--
