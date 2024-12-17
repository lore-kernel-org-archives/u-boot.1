Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DF2E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 17:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A5580214;
	Tue, 17 Dec 2024 18:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AN252zga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8DAC80214; Tue, 17 Dec 2024 18:18:52 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8918580107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 18:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b6e24aa0dbso433364885a.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734455929; x=1735060729; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xn3jsNxk2jjBSnXeoz9lCqFbRu2oK4cR2KQOGHF6aE8=;
 b=AN252zgaUVNMh215IcKkIlQ4VJT3XK9J91+GEwahAagnT5GTTbZdX3+ymZS4bi2oPr
 kGYLc95giIdLzE2qyu9ea4I8msBsBn922GlcmjPI83nEf0xpT7G1InNX80yDEJzq9F7u
 9lGZJ0u59byf53gE9CZvpKq5GPFFPk89eG1fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455929; x=1735060729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xn3jsNxk2jjBSnXeoz9lCqFbRu2oK4cR2KQOGHF6aE8=;
 b=h9LzWJyVFTOgEQndhVghsT/bQ56P3oj8zldeOeMPSbJ/qP3dmQueiSGlhAoJMEdfiH
 cG2QEvaGaHsKOc96tWFu2EynqgQn405A1gBavr8vOwIs0Ge2Sg2pfg/x6uyPFc6nTCaN
 2XDMGyRFWEFMPLKX9EE4vUE+QbvNuWTlItHqTEO0xpBl2N/6foN9bAXcJKgpFF5N6l8Q
 9IiES7aFBjsSbvdT6MXCfnVy9UzW/DQ293/tz4h/mLD7UdzkOAKT8D185zvyiPtiCCKs
 P4S6Jx6v2l76Nu4Fc3bthQyfKqetAbkZ6eHynFdIZrKiLT/uNjIThOWmAsq0XGLP/7dB
 Pq8A==
X-Gm-Message-State: AOJu0Yz/A+/usVVh35bqlPWMG2ladPV7o+9qGwd1qxy7eI1VtZia9Ayc
 gIXiENlcPj/FKTrWbQnmCDW9MGdY+DBrRIn3QvZwEzOZA0UoE6OCcvtfrtBRXKo4IxjxfkFSA4Y
 rIYc=
X-Gm-Gg: ASbGncv8/j5+lFdmzlz/ZXK5KU+i0IjKkPxV3cV2h3PB92mz5DGnoTjiP2rz+8TxMLH
 yH4iOMHBeHJlGZvF+2POxZn1PXswSgicB9ZQoBH65gMFTzDimW6eLm32iMYiNn3QNTdWvcfiNy7
 6TXVfVZx06NCfgIevt2Mdc1A3teo/x0fOauYO6O7mCakEUmk3uUj3teVj3rnTTxnXzeQvPHHzJX
 BpSnvgF3ZJhfpe+bB16+7n8RfCy75shtwBHeL5Q0SiO110Gw1z4Gmcg
X-Google-Smtp-Source: AGHT+IEuks7onLNBv7sttLpVCV+pf8BIK+/wb8nzJCcI6BSmbaxfwu8SUbpTyT0TlJjqWQzGuPaaqQ==
X-Received: by 2002:a05:620a:4089:b0:7b6:de3e:1831 with SMTP id
 af79cd13be357-7b85949635bmr502476485a.9.1734455929457; 
 Tue, 17 Dec 2024 09:18:49 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047aa3b3sm337018885a.4.2024.12.17.09.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:18:48 -0800 (PST)
Date: Tue, 17 Dec 2024 11:18:45 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] ARM: stm32mp: Fix dram_bank_mmu_setup() for LMB located
 above ram_top
Message-ID: <20241217171845.GP1505244@bill-the-cat>
References: <20241213132655.670837-1-patrice.chotard@foss.st.com>
 <173445589585.4187054.717117017229929078.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4+VuBoM0gevy55G1"
Content-Disposition: inline
In-Reply-To: <173445589585.4187054.717117017229929078.b4-ty@konsulko.com>
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


--4+VuBoM0gevy55G1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 11:18:15AM -0600, Tom Rini wrote:
> On Fri, 13 Dec 2024 14:26:55 +0100, Patrice Chotard wrote:
>=20
> > Previously, all LMB marked with LMB_NOMAP (above and below ram_top)
> > are considered as invalid entry in TLB.
> >=20
> > Since commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top
> >  even from same bank") all LMB located above ram_top are now marked
> > LMB_NOOVERWRITE and no more LMB_MAP.
> >=20
> > [...]
>=20
> Applied to u-boot/master, thanks!

And apologies for applying this directly, I wanted to make sure the
regression fix got in ASAP.

--=20
Tom

--4+VuBoM0gevy55G1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdhsnIACgkQFHw5/5Y0
tyxqFwv/XL65oalDpLtqmnjmpXon4KsfHBiZbr6wVymXDwIWfYC9hI3zQdWIuCps
c5avuV2D7BtKUaMQZBWEl7RyVQY9YOdBtq8P2HiZGnmXCoadpGnTHJWt/k+2At2u
ij+E67sboRHtKn2XHK6di23UEztU5x68r2Qh4b96L0ZMt/j8rJO2H1VPN0coBWcp
xpqCeiWy/FHt6EVXmeMW1zRX2mhZtVg4xFTLpZOt1udMFts/AcHXeJXags2MV9RN
xn5rl9Hp8GPOBSsxbKI96Oujta8PYC+4J0cxKxKnjLK5nNjee5eBtXdUZhCkjINQ
UURNemcwV11A6u1xyMuLzL+UvPk+vTCrlAmYyJLIeQXGPcDS+M5uSCya4sZwyP47
lXaDqcxs4Z/RDNMHdBExc4eLcyIYl3A6sn2HvwLGkMfW5qHbuXWkTypbj9zJJEwp
NRFBXvun3g8bBgus7FVVTIEl8L5KNycTlIsDJrJ5IpvMqBIJi4vGUABmOmYKkAsq
wIb6J6jl
=+Xzk
-----END PGP SIGNATURE-----

--4+VuBoM0gevy55G1--
