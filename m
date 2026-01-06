Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420C8CEFCF2
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 19:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8468B83D9F;
	Tue,  6 Jan 2026 20:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ONJu40tQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B64F83F01; Tue,  6 Jan 2026 19:59:59 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F45383C62
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 19:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-65d0952e596so97259eaf.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 10:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767725996; x=1768330796; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FrLkRRaHFBBYo+JCGLtWtuoo4B8l6Gunh+J1ajBoLRE=;
 b=ONJu40tQtd37Nk61fMKrR6jWz0ASKxKhqN5SZhTAhx7EntklfxSvIFf5e8z1me/KYk
 lFdL80CoGrFM09NmcNugXsYj9dLo93uofRj+xpDfh1BbVtr8Sgw6AU5LlyrmKptRVJmI
 zaeMPBPfVCLGuYtnjw4Ji6seOuDYLcz7qB0fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767725996; x=1768330796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrLkRRaHFBBYo+JCGLtWtuoo4B8l6Gunh+J1ajBoLRE=;
 b=mj8HrLJqVMmL1LoRIjDKozUjnbvXtdFzPFAbUgpG0tchVPMdm5dFy5X9bbRHSUMOfP
 e5+G4rO57rxCcuHDUJfd3XEBkT6IVdtywAzn6wCPGYJLc6O5cXwA1wK+HHN01rvvT52m
 E2JRM4pOVDRAnIb6Q3ZYU1RPqE8vlNNG0we9em1LF+JHm77Jeg0jrZImnFm0ZvSTVlYz
 Sx0QfgwdExXSCjqK5dYXFHLM4SQ3R1lzsgZsSsHNNmXYgsl5BRd1mwqmTRH393EKTnOR
 ITETr1sDnaxwtYf1X08NdNmZSbUhJoVve2YAZfdMFle3ZL3WXeB8P8deaJ354MDVU45D
 BVVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4mU3ffs+5h4wtoTz6O/BcQxng/DKKMp5RT7Ud9A0vPriceZs69R8C3GWJm4NMo9h7xMo6uPc=@lists.denx.de
X-Gm-Message-State: AOJu0YyMAUuD9PFDI76ibMlzJjL7+BMyqRypHtskFqN5lm1te5fF8Qyw
 2ZlkRO2cnJjdAhZzrhqFJoP8a52eRKW6WtXbgpO/ciUbEoLrgC+9nEeDKmmGz1cOoDBtnbazIks
 23wzGkyI=
X-Gm-Gg: AY/fxX72YA8ERBVhz8vPN0sdSLMEXDnTXnYzCVSYEP6a3ogX5AB7gh2FYUzArKh8EQ6
 xAQWqOItNYB3Gr1GsrAg+PjfTZWLBm4ebbp0586ajwVH/R9JpryZOpDorWxkHKsP1pHyDzes7tf
 0s2c4wBEiZrhSY4Ku/8eoky4v5rXK3NfhMPSjKWeKxtRC5+CHR8ecAifnQ+SWEUBlXU/Wi+gpKZ
 1+u7Tuk3qgioxHN2Yd8uqHP/7ccYUAImiVJ5d77l2w1KPhBl41qU5Vbjz5x5vGXOiD35XEGB2Li
 9EIp7OMzrm7JT7Gl+EhvIzt9CpuBQAKgQD4R+jwbEMxnE7WlY72GAx9wYqrqXaaSTbkIZoq9XRj
 Kz2TIzpCY/zGJYW0aEE4i26D5v/fwg2c7axTsLpxOzwknMXD1BF8ZJa713oRBSYuDANrT5pcn4h
 6qRDHZtgrtDRIulZu7Tt1/wct2Q3bCpGhH2LwQjhjPVH7hpRHFrRp4sg5tpn48dNxIG4wKKq/lf
 WLV9PAUM3D3TkVk9LRjvFOpEBDV6MWb9Y9PM9Q=
X-Google-Smtp-Source: AGHT+IGHkUk/IArKd7wc04Pb5A6Cw7d16oxU4F4UfXxQxLaShvKco2renF+WWHPoPxrzADNNMGuoQA==
X-Received: by 2002:a05:6820:601:b0:65e:dd95:396a with SMTP id
 006d021491bc7-65f545b2cd3mr74571eaf.7.1767725995996; 
 Tue, 06 Jan 2026 10:59:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48cb03d4sm1305419eaf.12.2026.01.06.10.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:59:55 -0800 (PST)
Date: Tue, 6 Jan 2026 12:59:52 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/8] clk: mediatek: implement of_xlate and dump
Message-ID: <20260106185952.GJ3416603@bill-the-cat>
References: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fCSJBSk/tHrwlbtM"
Content-Disposition: inline
In-Reply-To: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
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


--fCSJBSk/tHrwlbtM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 11:16:58AM -0600, David Lechner wrote:

> I started looking into fixing some bugs in the mt8365 clock driver and
> realized that there was no way to inspect or debug the clock trees.
>=20
> I set out to implement the dump function to help with this. The driver
> architecture didn't make this easy since there was no way to know the
> number of elements in each of the clock arrays. The first few patches
> in this series are adding fields to the data structures to hold this
> information.
[snip]
> ---
> base-commit: 930eff5416ea98ebd09cec73f5d06a7033b4d52e
> change-id: 20251215-clk-mtk-improvements-db0b9d1d3113
> prerequisite-message-id: <20251211-clk-mtk-fix-dup-parent-doc-v1-1-41816d=
98f857@baylibre.com>
> prerequisite-patch-id: 2ae6231f7dcfd6fb770d0633c3feb5ee2a3dab1a
> prerequisite-message-id: <20251210-arm-dts-mediatek-switch-mt8365-to-of_u=
pstream-v1-1-71317e50d414@baylibre.com>
> prerequisite-patch-id: 3520ac6a30d21a4efac14c4d2cae0d72912f9f13

So, unfortunately this prerequisite feature in b4 doesn't work well for
us, or I'm doing something wrong. Both of these are applied to master,
now, but b4 wants to re-apply them, and then falls down.

This also, now, fails to apply cleanly to current master so can you
please rebase and resend? Thanks.

--=20
Tom

--fCSJBSk/tHrwlbtM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV1boAAKCRAr4qD1Cr/k
CtP0AQC6zI40IwpjJ1TynaputavBm+dEbMsCKXBuo3RsM37D6AEAn8w5DPCPqVNn
VeaMEnFJiSFyWqRpB59tYifyJKVMtwQ=
=PIJ/
-----END PGP SIGNATURE-----

--fCSJBSk/tHrwlbtM--
