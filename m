Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4113DC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1943F87780;
	Tue, 19 Dec 2023 18:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gOdjJiY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247C487767; Tue, 19 Dec 2023 18:46:00 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 140BF876F6
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5d33574f64eso37642477b3.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703007957; x=1703612757; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZS5sX9iIr0ViEcS0JDcqxEzYqCmg9gHNZ/aIlmPvHY=;
 b=gOdjJiY7bBJS/mhqAHGSh3I/0FpJJSTo4hRDPjXSKj4uNkgM2elIzCHqni1ak/O9Fi
 l2h2eLr4tGbxpKz6/d0id7aC2GdHCO0c0Jnx5gHpP8v5ZUu15JAnnD+ixhr7XHzCPBYT
 jfb1R7OlpHiD4yFxzsLsVA3WabQrJgDBRTR7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007957; x=1703612757;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZS5sX9iIr0ViEcS0JDcqxEzYqCmg9gHNZ/aIlmPvHY=;
 b=bJwKeYpfC9lJbsiiI18ldvOHfYVWIaDyjoiPBmSCNqiVIkxlNEOrf90/PMO9UggNx6
 rhXyLXlpGoM2w5/41PsYoeDbtxnKf32MGY5m7Xq27b7yplqmP6p6TL98t8YlVCVyv4BA
 9hFmiecGHmfet+mYwho0a9BsBG1k3X/5v/mDxY30/4OgWzsU/06NFsWuRb9FaE57CqWo
 90gMSb7fYRCdqfc7dK8yscVlsCov/FjShEUzKSnmy89TgWW/L7GZexagzoTi6VfG32d7
 60UgRNhm8eKz1lPb+BB7mWmSQkoFSDaF/Y+OA4oN2MeqpeMrJuL/SVFRivPfIvfw6pfK
 CdDw==
X-Gm-Message-State: AOJu0YxjiS17O1vra1Ho2Ildn6DRawRkVplnLGiHpVTuJcmjtzIQwtTo
 E8xlRE4k3xcSy0kKNhnnX1YW6g==
X-Google-Smtp-Source: AGHT+IFOxdewcv8Wg0zYeGLqUoWP+XYnrAZZdboiE/P9eUnKVdEhsovmBqkCMlkrM0kvquYRWPmFGQ==
X-Received: by 2002:a25:b904:0:b0:d9b:eb86:2b26 with SMTP id
 x4-20020a25b904000000b00d9beb862b26mr10956330ybj.21.1703007956788; 
 Tue, 19 Dec 2023 09:45:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 v62-20020a25c541000000b00da10d9e96cesm1277721ybe.35.2023.12.19.09.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:45:56 -0800 (PST)
Date: Tue, 19 Dec 2023 12:45:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: mdio: Add tests for mdio command
Message-ID: <20231219174554.GZ2513409@bill-the-cat>
References: <92907606c7b930808b82582bea752d4cee13cae6.1702988434.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A6Cil7y1o7GewszJ"
Content-Disposition: inline
In-Reply-To: <92907606c7b930808b82582bea752d4cee13cae6.1702988434.git.love.kumar@amd.com>
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


--A6Cil7y1o7GewszJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 05:50:51PM +0530, Love Kumar wrote:

> Add below test cases for mdio commands:
> mdio_list - To list MDIO buses
> mdio_read - To read PHY's register at <devad>.<reg>
> mdio_write - To write PHY's register at <devad>.<reg>
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--A6Cil7y1o7GewszJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1tIACgkQFHw5/5Y0
tywPXQv+MQ51k7/VsyngcoM3oEjZT0YoEp66/XMB4MkNVVc06PPxQnJSag1ivR9t
TDzSFjJD+OQ90po4adRlzrUPIT1/qLdHg8Aiphu/UdPNglL76EiidNUXe+XNaHzJ
Vo5f4/wtg4RCd2x3cpfr9NYgOiaNzZAm/3bgwGI5GHkyjmv/iHEmEiRQ3mg24oNs
IYnPFZKrFr0nQC56bxox+G6bAYEBnZa9az89rxAU0/I+xoyDCa+Q0IOlLMuQVgVT
feS+iEepktfaww2O3tcYpyrtNcaxBcv/ZGEjjXWuAvXXWEhAXaTnNeaWCvypD0XN
ZOcDuBTfcjBTM+Yw0vasPuQ1J20x7If+fjdnLHNNDvzVCQxqODdE1B2/aAHzZ9S5
7qTZ5eaAno6h0STMzONwb+T9GsN7w4a0PC3ect6V+e+3iyDpCEStZtp/Ugtnp67P
UskTFIp1x2JgspdfptjoYyWFugJD+bDDmxilmLnSLKYS4uslmpIJqBzP5QYaaG08
nOZ+tlqm
=R9o0
-----END PGP SIGNATURE-----

--A6Cil7y1o7GewszJ--
