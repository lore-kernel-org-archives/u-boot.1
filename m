Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F37CEFC38
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 17:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC1A988C8F;
	Tue,  8 Oct 2024 19:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IFM1Eo+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C6588B1F; Tue,  8 Oct 2024 19:40:01 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5761788E5F
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 19:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cb7c312b6eso45195096d6.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728409198; x=1729013998; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3WgkAF1FXdHRSBm+2+rJoOhMNkfeA99T6agllPlSL5U=;
 b=IFM1Eo+Jl6To7cxG9FUph1MZ4H+NNPaORMhZeHlYRX0xS09nlgOts5JtyHo7XLqmyU
 z1qPqvbp5MswwfCsjmjCT1CtvNm9KNmiFDfxQCx9cwZdngkAfCUZQsS/gGtDiilZkj0h
 5aqjDvTn7mhhj0jwNJrKmyG8n1LN2UOOx9lII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728409198; x=1729013998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3WgkAF1FXdHRSBm+2+rJoOhMNkfeA99T6agllPlSL5U=;
 b=cfDsPxtwRzeMGMFwod5ICxUrlS+3fjf86j2mHu7ki463f8gKv+9Hzu/TVCYe+M60GE
 wxgFrk5C1H+DoeUhe6my/CE7Leq9uiRnr51XmlryCMlSU28WxjYRN7J4G0ZCS6orIRBW
 w3HmdXCn73zebojf8FSMOnq9wMAn7kRU7U7rAOdnyEEQs6pWb40Y7iPEdO0i7GnUfNcp
 HfnQLO9qIeyXWKj/SkyTo/qhMcZiCa3sPotErqoV2+jZlJcHZXRQV4fvFIJeSbKcSQHp
 PVe79vEsXqk4oWkf8SYSTEQiA2pk7lk3wXn6/f5AROqkHNCjGOLCRjwChpD8XZ01sQt9
 2aGw==
X-Gm-Message-State: AOJu0YxQ8nv6s/qbf1KGaxa8wwQ9Lld7Z3EkIjgqNF8lws3YOZlKpz9V
 cVKkxhFpfcwfp2OE/JAzTsq6UZaT50jXifNl37t4gjaC4amC9CeFeeKtxo+lsZE=
X-Google-Smtp-Source: AGHT+IHstfOMi5fIvKgcFE6vpFHuojwkchZoqChdAre54PYVqlYXsYe7FKnO5eHPuELjVjyBnay3sQ==
X-Received: by 2002:a05:6214:5d8c:b0:6cb:a3cc:53f1 with SMTP id
 6a1803df08f44-6cba3cc5471mr211494396d6.39.1728409198129; 
 Tue, 08 Oct 2024 10:39:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da75ed6besm38205701cf.75.2024.10.08.10.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 10:39:33 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:39:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] watchdog: introduce separate SPL symbol for WDT_GPIO
Message-ID: <20241008173915.GD14210@bill-the-cat>
References: <20241007174716.1068936-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OJDHuEfKwhAR7Y5i"
Content-Disposition: inline
In-Reply-To: <20241007174716.1068936-1-ravi@prevas.dk>
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


--OJDHuEfKwhAR7Y5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 07:47:16PM +0200, Rasmus Villemoes wrote:

> Currently, enabling WDT_GPIO on a board which uses SPL, but does not
> have SPL_WDT, SPL_DM_GPIO or SPL_OF_CONTROL enabled, breaks the build.
>=20
> Make it possible to use the WDT_GPIO driver on such boards by
> introducing a separate symbol controlling whether the driver is built
> for SPL. Make it default to WDT_GPIO such that boards that already
> have it enabled and all the SPL prerequisites satisfied will continue
> to have it in SPL.
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--OJDHuEfKwhAR7Y5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcFbkAACgkQFHw5/5Y0
tywpGQv+L/PvGAzZyaBxbPVENJkEYDP/jPP1dpmPa1RpmldnXbgPJUwT62Ce4q7w
7eECERxL7vJUaDCjzBuPuLeU1gWo2z5WrwkjPk6QwjoZuGyQn8YHJ+K8834/5jMS
1l0h8co+r3JEgVTzK43NRxayUQQIhb0AV8A/ibyF6TAHxwETzLRSAskjWu8vKY7M
bl38t+ATqu4dVu6bLPttVPwGdA49JUXQL7v6ragIoX6YvlcBs4Djcj5gx/kV6tyH
DTb+cGJ6tkK5pfTqp6/2ahAqJIV/qtfK0yxFMNxyHSV1h8lzo6hY30pXsk6jwH1+
itNHNGTLMbnFTB3KAucrMuk/aJh2ClxKS+Y/XcUJYUkdVFVY/CRsbA5Zr1VgJpfK
8GiF1PhCaam2ODtnVnLqnBjyFg20nAFaN37kSPoWsPx6bSBWwykaZ96w5KmZnJws
vV6XrytE8K7GSiuw0U6mhZ/v45jmjsKTAPBHJGa6icFagPW6sKQm/x5MECyJYWBd
7Zwqkaiu
=uRYH
-----END PGP SIGNATURE-----

--OJDHuEfKwhAR7Y5i--
