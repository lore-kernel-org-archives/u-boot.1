Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C729E10F995C
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0385984154;
	Wed,  8 Apr 2026 18:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cnK6K0ge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27DF58414B; Wed,  8 Apr 2026 18:26:09 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102E084142
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4710c186d15so14250b6e.3
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775665566; x=1776270366; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6FAbaNNe2tJKmIDqtKMQmPywx7vWW4uGJg08S0Vlt0=;
 b=cnK6K0geIdrCKsY+vQ1CnTUsqssRhf5J7mRg2z8Hiu9L8mFg0PXj/r9cLCX/yXT2Hw
 oZKgabwq4AK6XNbaEEfrcGonccJTS2jphe7ap/IqRS4jbV6d6wCDa2zUXrOmLYXGH8hf
 GZcYZfHSASeeRtwDRxj2vLAHksFQ4Ot10f+jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775665566; x=1776270366;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y6FAbaNNe2tJKmIDqtKMQmPywx7vWW4uGJg08S0Vlt0=;
 b=kTzpo68QqbEr6u2R0IOPIQAOoPAePLX+zrnCVpQCvR/2nFfcj6y0awXRAcsoYguJjl
 BdjIGCN0ojF/CA4H1BoHSM65q8h5CaLE3iM09R8Jzw67xjiBLZ3Mj5WNxWDnpaiMGSuz
 PKFoTIH2lcjmGJ/Aip6gZ4xR2pNHZ5rhcSjFaNxwX5skYRMK2DmtYF3+KAMq08nfFz20
 ozXZYTAcUbscC81bZk7tC0ESLw5R9fTLu42UJkustJRwsCs1+Oj3p2SMRcdCTxLaDPh9
 /uiv8AI0V69vMmKhBIo/WWDO9D3ae9HK8DdzPoag0bjyCE1yV2CmjKcTL+jN0wcQTQWQ
 7ftw==
X-Gm-Message-State: AOJu0Yw3mU+331nurgncPGPrmIuIlf6/09RrBGYJj4XzuNg9sNKbV4+A
 GKoW2031xVgcbawkXAK9bHqLVsAv8mHwq4MqJmsfxbYi2iyRvqQSlzdXXPIewqHAHic=
X-Gm-Gg: AeBDiesKHKWg6rZCJ6f2xHZtqSFXCxsRNZ9adA0Ix5zI1agpQJQ8aOne49Pm6sacgxk
 FvVClLM8ZitrznjUE8sXVBDjxbyZB/TzR6XVib59X4NmFWaCEzi770XbPYiXKMS76k1sb7bAx2j
 RWH0u2VvUo8lE33SOhseNF3vyVaEY6hO33OVhh7/z4Ctz84shSaIfGGaOPXiqI6Le9ITC9jL8d7
 xxugVONpSn5kzufaUUriSOoSfVBNLzhT2UjEr8Wz3k/xtcJXYgPbbYKUz0ZsYec9UKQVVR8B7To
 xOZRP7iPi4cYKt8+w64QdPkvlQwlkoPDOnzgMsfPH47wJ6IrUCQXg/3DcV6wdqLWZy9VikEhQFy
 XDDF+DEP7sJcJ9pYO2qEWexQN8Is5GtbWWExgq2XpGBGEk739XwncMn09nWoP1g2R0C8EjUCJ/Y
 kEVLWeqwkAZjtaux9nxCn4zDSix5SUrwbRa7kAv8JrrL6caw+x7d+jvUf+QRYitPACFvx2uYq/K
 eQLGER6v+vtjy1GYuVKqZhGMpwXVhFA4C1XBuIbrYV90nci/yVItYrJO/0=
X-Received: by 2002:a05:6808:444a:b0:46a:746c:2d53 with SMTP id
 5614622812f47-46ef54f5480mr11778761b6e.2.1775665565758; 
 Wed, 08 Apr 2026 09:26:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d93167969sm11791312b6e.14.2026.04.08.09.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:26:05 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:26:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: Re: [PATCH 04/13] boot: Move type and OS checking into a new function
Message-ID: <20260408162602.GG41863@bill-the-cat>
References: <20260325165431.1027591-1-sjg@chromium.org>
 <20260325165431.1027591-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0iXHkr0SU4Aw0VPc"
Content-Disposition: inline
In-Reply-To: <20260325165431.1027591-5-sjg@chromium.org>
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


--0iXHkr0SU4Aw0VPc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:54:13AM -0600, Simon Glass wrote:

> Move the code which checks whether the image can be loaded into a
> separate check_allowed() function.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Switching to an enum is useful for various build time reasons (and
wasn't called out), refactoring code that's not heavily nested is the
same issue as in patch #1 of the series.

--=20
Tom

--0iXHkr0SU4Aw0VPc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadaBmgAKCRAr4qD1Cr/k
ColUAP9uJAbuJVieOpITA5PHfxmyzGzKfT0Zx4PATADLCfD6mAD8DNt2lxiTQiVv
FWaLs2LrJd0CKNsf/nZGvXqOnbFJfw8=
=Emlk
-----END PGP SIGNATURE-----

--0iXHkr0SU4Aw0VPc--
