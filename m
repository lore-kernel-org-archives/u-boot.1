Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D687BCD13D2
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C7D8063E;
	Thu, 30 Apr 2026 23:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HOYlPTjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF03E83693; Thu, 30 Apr 2026 23:19:55 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C173803C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de431da8fbso1280523a34.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777583992; x=1778188792; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+wD/dk7lFV4oLrSC5psD/ZWEC/K6khko3MtkbjbfTrY=;
 b=HOYlPTjflVtbULOn8ed+3AIaCqQClckuM1zHDmolxxXcy2LM8w1jvnJqM/ME92xy8D
 OY/gJxZzxZDF6wpupDttnJV0Y0AvD+AS2ncwPPzO/WF05Vywv795bXBgbagaUsHXullj
 JrjhhRiP0BghgWYW2IlJ4dx3MBfgSdcrj7MWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777583992; x=1778188792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wD/dk7lFV4oLrSC5psD/ZWEC/K6khko3MtkbjbfTrY=;
 b=rX0zuqSJGobtzSPf64ve7uh1Cx0s770yvsXCMJYrwXcS3GwNysLFWhcYgmDEf5Uzhj
 eLA5Xhmmkw7JrqhoPF3mLB0+XssQ8XBuHhlForp/+vpYp8S8FvPk934qlpkDCWSdmQoy
 LDJyUTPJpuOaEfn2CdYMCHcqIp+mNl0I5pV356kqbkO0yFruaIJsFj30Vn9+PNub/kZU
 N7q6SkcBPziyx7kLTGzau7f5jVLeNUA2j8bPsMIWiVRsj1l2ZM//xqdVK1aogzza9vdS
 NveHOpywbEABesW2Ky/dFoD6PP6esKzxRsThzCLIBlvr/F1Y0DpjSibjOCqcdRxAMkLN
 7CUw==
X-Gm-Message-State: AOJu0YxqSC+2ijqIt2AB6hZyyb03i8PN2r+njzgOVLnTim8kVRXyJyQV
 8S/Ef4N8zuOUckvgKmMbDqRRXNszBo6lOGY4cdAOrBYw9YB8sewW69c3m08pEHZHz3I=
X-Gm-Gg: AeBDievxo9mPy88evAOUMQJOywx1Si/L8nsjvomJrJTOpbgINlL1odzM1aVHGLLDrS1
 h5HwVe9bm5FmfdFhdB+YOVIJhD2Kz2ulmYS0fWHCqYg8YIUtjYKDc1VK9EipBuXFjoSZhpy1XCG
 WxM7LFpWP6YX/Efgwl8E8njtimr4V7dewV4NkNy8kmlsntjv9FhYPeyvME7fsgqmatVjNFLoLEg
 5FlshRG3ilGUwsfFCa2lNCF4LB0DFqoWhVWdSBKmdF1kAWxDknDUQHfhJdsCduqgDFS0s+SMM0X
 Yy+8FdxGXcQDzQLLGHHZa0phU91v2jOJHZBCclJrDXhW0FG51Nr8muLetV0qTnPlLkhS1PU2g/9
 PPOz/XfpnBk7i20I9//UOy7LC5LK8fCzKsEYYONUU1WqbNAeJQPTosHXZIwKcDa2L4OAVQV53mN
 i68L30kqA/AG59oOQzyyN5hKTzCa1KrdSVZaMT/G48oos9OfICX3lROC9l4QCbB4XYcF62w4IlV
 6uyaPqQlNSi01NZBlL25rCUbA3RV5+iwo6IsTtBxe4j8UvtBJdb7nAF8yMG7SdnujDJOjcn
X-Received: by 2002:a05:6830:25d5:b0:7d9:7201:1acf with SMTP id
 46e09a7af769-7ded07f5387mr268332a34.5.1777583992205; 
 Thu, 30 Apr 2026 14:19:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca80d5b7sm695774a34.9.2026.04.30.14.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 14:19:51 -0700 (PDT)
Date: Thu, 30 Apr 2026 15:19:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: u-boot@lists.denx.de, Maarten.Brock@sttls.nl, kory.maincent@bootlin.com,
 msp@baylibre.com, sbellary@baylibre.com, romain.gantois@bootlin.com,
 pratheesh@ti.com, j-rameshbabu@ti.com, praneeth@ti.com,
 vigneshr@ti.com, srk@ti.com, rogerq@ti.com, danishanwar@ti.com,
 m-malladi@ti.com, krishna@couthit.com, mohan@couthit.com,
 pmohan@couthit.com, basharath@couthit.com
Subject: Re: [PATCH v3] board: ti: am335x: Conditional MDIO PAD configuration
 instead of static for AM335_ICE
Message-ID: <20260430211948.GA1717275@bill-the-cat>
References: <20260422123353.2902537-1-parvathi@couthit.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="asavWXHJ33YBBROV"
Content-Disposition: inline
In-Reply-To: <20260422123353.2902537-1-parvathi@couthit.com>
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


--asavWXHJ33YBBROV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 06:03:03PM +0530, Parvathi Pudi wrote:

> This patch removes the static MDIO pinmux configuration from
> rmii1_pin_mux[] and instead configures the MDIO pins conditionally
> during board_init(). Previously, the MDIO_CLK and MDIO_DATA pins
> were always configured for CPSW in mux.c, which could lead to
> unnecessary pin ownership and conflicts in scenarios where CPSW
> is not used.
>=20
> With this change, the MDIO pins are configured only when required,
> ensuring that CPSW Ethernet functionality in U-Boot remains unaffected.
> This approach keeps Ethernet boot behavior intact and provides cleaner
> separation between CPSW and other Ethernet use cases.
>=20
> Reviewed-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>

This leads to failure to build on:
am335x_evm_spiboot am335x_hs_evm am335x_hs_evm_spi am335x_hs_evm_uart

--=20
Tom

--asavWXHJ33YBBROV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafPHcQAKCRAr4qD1Cr/k
Cj0JAP40/6A3NnV0jCigQZAwyydwdjl39djtewy6KBlwQcxGJAEAv9maeR0fm51D
ex5VhJyp/6xAZWQCzOR9vkepSIYPDgM=
=Sf8z
-----END PGP SIGNATURE-----

--asavWXHJ33YBBROV--
