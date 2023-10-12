Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E597BCDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B629F86E95;
	Thu, 12 Oct 2023 23:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X7aa8Z6N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 921B086E87; Thu, 12 Oct 2023 23:12:06 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3855D86EB9
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7ba0828efso17748567b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697144646; x=1697749446; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8vC5UqzH+qiVAFjvYrKOFZcklHRjmdQ/9Ee0Mm6C4bs=;
 b=X7aa8Z6NBxSsJzZfvp8VbReuyCHxtu5BCzvuc+lAJF8JhGbLreM7311LcU9iMPvBdd
 1DwWUmwasQ8HAqhMxlp5KsWcG1cZhw9tZSxmloVJaC5y/ZlrgEUGfm+eNXlAIec/AWsL
 +kfFojE7RdxfnyXo2SRsyvEWwD8NsAqbg+muY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697144646; x=1697749446;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vC5UqzH+qiVAFjvYrKOFZcklHRjmdQ/9Ee0Mm6C4bs=;
 b=fs0Rr8qd/KsdAStW8NrfC5+zgYDKwyvXUxHdo7Y3V9Z8987RhbRtls1BingcPEwLnM
 4PAjVHY0opXf8lvtX7HETTU07igmtvnMh265FnuSuk8rFhMf6RrsyrSJT6GuN45u8q1S
 dzqgrT9WyKzlZuNsgiJANxSTqN24HKF3ed8DwgAvdS60EbUKGck68B5A7qkMptS8SVpG
 0GQM5mrqT6Xad+HSB1S4LrXr7n1AS3/fRHp1aS0EDYnqA6xYhiYCOgchF60qv8aBwx3/
 zIjkY4RVYhR9GwyNKBn7Qbw9wwLEMD1A3Sm+jnno4WpY0MDf08AIkpp6shFz5sP6NbSp
 YlEA==
X-Gm-Message-State: AOJu0Yw8VeAPMjfHcgYkwScGi9D1Nxc7ib/H7AehdeeNK6TRO0l5AFX8
 jImwcHdN/0j+AiURzq1EANSQ4g==
X-Google-Smtp-Source: AGHT+IEWwwqKPeBU2xKXMqliejV+aZhm2wqWmBL/Jm9BpkW6GTm/dlz214nEH4bD167zL7hWmUg0Yw==
X-Received: by 2002:a0d:e905:0:b0:577:3d46:f90e with SMTP id
 s5-20020a0de905000000b005773d46f90emr26416795ywe.32.1697144646392; 
 Thu, 12 Oct 2023 14:04:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 x190-20020a0dd5c7000000b005777a2c356asm217406ywd.65.2023.10.12.14.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:04:05 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:04:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Andrew Davis <afd@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: Re: [PATCH v7 1/7] configs: j721s2_evm_r5_defconfig: Increase malloc
 pool size in DRAM
Message-ID: <20231012210403.GA3119521@bill-the-cat>
References: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
 <20231006-b4-upstream-j721s2-r5-pinmux-v7-1-5d31f765dd2c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y2TIRLdDLUFqbBcE"
Content-Disposition: inline
In-Reply-To: <20231006-b4-upstream-j721s2-r5-pinmux-v7-1-5d31f765dd2c@ti.com>
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


--Y2TIRLdDLUFqbBcE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 10:15:55AM +0530, Manorit Chawdhry wrote:

> From: Udit Kumar <u-kumar1@ti.com>
>=20
> The malloc capacity in DRAM at R5 SPL is set to 1MB which isn't
> sufficient to load the new tispl.bin to
> enable loading of tispl.bin the size is increased by 256KB to 1.25MB.
>=20
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Reviewed-by: Nikhil M Jain <n-jain1@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Y2TIRLdDLUFqbBcE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoX0MACgkQFHw5/5Y0
tywHowwAr2PffUDOrklqy3NunQ9A/2BL75y36GMGBoPn9tolJ4iEmRorat2QcHsC
MUOB1QXZgDcTUwhr7DlZ/qxDAs6U4i2Iej7Nj2DvpQqnQdYnX5sOKs+gOHnTWSfA
HDKHwnUM04DxGZssEm4yk8L6+3pkwL3nJET2Uc45dhwz7YO/WtwosGs5GOp+jON2
hIH+LZCrtiUXd1NUqtfkbCe5iqVI7/iZKpsHNmdQsbPPx3x1RpmNLP/maS/SwgoS
aWCV7elnVEyST2eWtnWIttiPPLyjNUkXiaP1ulprrgRb+eYn8VbnFVergXglvG0Y
KQet3tZ56IKfKbNd03aO1na26AllakWF6P4PFgd91G0AkkaSyueJDm7F11aeopiM
WoYP20y/caVaqq+ZzUs20uxSY879eZHEzjXkNj6/pNsgUucZ0YB/BkuNi992Bq7Y
tOMU5yoq+mCP3rOzru5D4VROtI892LWGXymkFTn1G4spNokku/LDZ+xKC2/Itb0L
uAwtRyra
=EtFv
-----END PGP SIGNATURE-----

--Y2TIRLdDLUFqbBcE--
