Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EEECD3424
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 14:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 072D580F0E;
	Fri,  1 May 2026 16:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GXTMFwzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0788C83E36; Fri,  1 May 2026 16:43:44 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7CC080086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 16:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-41576c5c01cso1071872fac.3
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777646620; x=1778251420; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/Zn8O9Y8GfjkNa0jkaflwc2/RKa/lZ6spcylb/q9euc=;
 b=GXTMFwzR33SrmM09q1J2sIhc6yB/YbDvABupbd3wNm50CyN4D6Fjc+LtJJfJqHaAiV
 R+J8QY3QJvGLYU9z/DLlB4tzBsIwjGOMbxg254Uz6/uOwA6u5v/vdUtCBNYWJC0eUviI
 go7zRwWMUybiaYgw9E3UVS0lqSOGtffJ7ggWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777646620; x=1778251420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Zn8O9Y8GfjkNa0jkaflwc2/RKa/lZ6spcylb/q9euc=;
 b=M+0yhq2XDXXNlKryYQx14BJRaGA+Lfd4da0Azus6OYVtJg1zWWEhr33WDhHVbnSfkq
 ZGtxRvA4Kc/0fx1Pjwi8Q69Wq9bBlqRG3yn6hWmwflTCeXYK7mSLlbfL8OEPZM4zr37o
 tsKS7GrMlX3lGpRfdVPPfHnAqex+LXG9tFdj6qnWxuXHRfaLsAk+Ck1OZIodX/WDNEBl
 sdpuUJEo/kR/U0kQBM/G4ZbnCjzabXPYOEnDoxGaHeaicIMYqfChzD7KysUa4vesuPBa
 9itjy+QJmKK7Y9Vj4rSpDOQVQZMqo1b/zYZuCKozvLQZ23izEBlHy1tIr+s5CG6rgpR4
 FPnQ==
X-Gm-Message-State: AOJu0YxFp2rrJFdFKPuTv5r2yTpwfae46+6+ww+IVpq6cf5OtIuovkwM
 zLyMvou39UO0yxAQCs7ORiJvi1vzNcJ7YSJraa77stgzdFQxJpbHtZ32VN2i5NIA3OgkpLoNdR/
 FX02I+FHcjnlg
X-Gm-Gg: AeBDievpYmVeOwwFeF++AdZRlz9lVQmV+zbZnvqKGwLYkXJrJV+wrvHZurvlazwK9wd
 LRFNzjCrwV25accFgOuLCA8sTJlg+u5Vqt4R5robfy2ON0jcAzgXstZAhHKV6OmyVAYyXVUYjVM
 ju7z+nPh2Rx31l5bGrTvnpM8Tr7bgdIyDfMG+X0/z74JT2olUNIz50Pc9ZLQcX8Obw4tf+VvJ2V
 G+neQymN6cFE2zuM2exq2uE8W1ysLnmdAfwqInHQp10fVBnw0E5UC1jolXCr8VM7x1y1S7rJnMQ
 vi0XHT6LGFqya5eD81Aey1wu9NqIIiAyG5fQCLadMjCLTa5NPUGpqZMyIMVttmU7tctmX5Y2js7
 3zCPiysM64o03BoIMfddKliCG3oryMTZaNM2hPbUhC1kxRMjKKV+cMVDA80ZbEkMal8OmTqYMt2
 8mbpopuhGklss/YsNfc1IhASbLN75TcweVxTnED14/gIOT9hzBaNT6UvRtsL+Rbbr+8odQGxcc4
 IGzetXZhxCiH63ic1R95b3tuwA8Z/NgazTzEGgx0XKeg23JExm0LjKLxTDLgw==
X-Received: by 2002:a05:6870:a0ab:b0:42f:f390:d7 with SMTP id
 586e51a60fabf-43433ba1777mr4275588fac.21.1777646620403; 
 Fri, 01 May 2026 07:43:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454d53a55sm2848401fac.16.2026.05.01.07.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 07:43:39 -0700 (PDT)
Date: Fri, 1 May 2026 08:43:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: u-boot <u-boot@lists.denx.de>, Maarten Brock <Maarten.Brock@sttls.nl>,
 kory maincent <kory.maincent@bootlin.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 sbellary <sbellary@baylibre.com>,
 romain gantois <romain.gantois@bootlin.com>,
 pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>,
 praneeth <praneeth@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 srk <srk@ti.com>, rogerq <rogerq@ti.com>,
 danishanwar <danishanwar@ti.com>, m-malladi <m-malladi@ti.com>,
 krishna <krishna@couthit.com>, mohan <mohan@couthit.com>,
 pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>
Subject: Re: [PATCH v3] board: ti: am335x: Conditional MDIO PAD configuration
 instead of static for AM335_ICE
Message-ID: <20260501144336.GE1614990@bill-the-cat>
References: <20260422123353.2902537-1-parvathi@couthit.com>
 <20260430211948.GA1717275@bill-the-cat>
 <239785101.1054803.1777630782561.JavaMail.zimbra@couthit.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hvXMf2/1/L5tMU8Z"
Content-Disposition: inline
In-Reply-To: <239785101.1054803.1777630782561.JavaMail.zimbra@couthit.local>
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


--hvXMf2/1/L5tMU8Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2026 at 03:49:42PM +0530, Parvathi Pudi wrote:
> Hi,
>=20
> > On Wed, Apr 22, 2026 at 06:03:03PM +0530, Parvathi Pudi wrote:
> >=20
> >> This patch removes the static MDIO pinmux configuration from
> >> rmii1_pin_mux[] and instead configures the MDIO pins conditionally
> >> during board_init(). Previously, the MDIO_CLK and MDIO_DATA pins
> >> were always configured for CPSW in mux.c, which could lead to
> >> unnecessary pin ownership and conflicts in scenarios where CPSW
> >> is not used.
> >>=20
> >> With this change, the MDIO pins are configured only when required,
> >> ensuring that CPSW Ethernet functionality in U-Boot remains unaffected.
> >> This approach keeps Ethernet boot behavior intact and provides cleaner
> >> separation between CPSW and other Ethernet use cases.
> >>=20
> >> Reviewed-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> >> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> >=20
> > This leads to failure to build on:
> > am335x_evm_spiboot am335x_hs_evm am335x_hs_evm_spi am335x_hs_evm_uart
> >=20
>=20
> We tested the patch locally with the mentioned defconfigs (am335x_evm_spi=
boot,
> am335x_hs_evm, am335x_hs_evm_spi, am335x_hs_evm_uart), and we get the fol=
lowing
> warning:
>=20
> =E2=80=98rmii1_mdio_pin_mux=E2=80=99 defined but not used [-Wunused-varia=
ble]
>=20
> Are you referring to this warning or do you see any other build errors?

Yes, warnings are treated as errors by CI and so must be fixed before
being applied.

--=20
Tom

--hvXMf2/1/L5tMU8Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafS8FQAKCRAr4qD1Cr/k
CgGvAP962djUXAmgjXqY1m7G79FfIKx1+BHfkgGBOLRi2gJ6hAEA9Zleske/a6Ur
uOCK81Ol4YGR4nque6NOXXxt/daYcwA=
=V80b
-----END PGP SIGNATURE-----

--hvXMf2/1/L5tMU8Z--
