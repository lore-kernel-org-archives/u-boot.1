Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46947C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93FAF80763;
	Mon,  3 Feb 2025 21:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SX5Vkj96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D82D807B9; Mon,  3 Feb 2025 21:09:45 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B5A380790
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b9bc648736so474904385a.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613381; x=1739218181; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gzSUfuYppgt9rXGUeS9HejpH1PJdcydeJ+/dVNEhGEM=;
 b=SX5Vkj96wtKSCGUD87cLHtdWMJbGVsNJrsd/3PYnsdLZ9dEr2TFrZ1bld4ogI6ON5T
 PeLRuvWGnIKYCvtJ8CgJUpFKp4QuUvwI5oBk8QSzOACz9DvWNlIYhIBeR+hkTP+hA5hg
 sCLXV2ySrcjW2pZuq8JWZu/hOVcdgWpFgr0n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613381; x=1739218181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzSUfuYppgt9rXGUeS9HejpH1PJdcydeJ+/dVNEhGEM=;
 b=imcKyUSBcCTDpCpNywzrGLeL+IWKi/LwsufpvD+5xIba81ZQr9wQBnbmhlfRoZSk06
 Ytul+FA3S7RwiRBH20LBb0zsW7ybJ8DDYFomRWREVJpwU+zX/LUFnzB4RhAZsU2oLGP5
 NGYivpYq1MQdkgDxqzdT7Hqu74D8WUQYOwGiN3GKDobGNp7+OqOeoKxW8f3Y7oYn1M/C
 EJBXPsYOiCXfbz9RnB7f2n9lqNCYBL+EQLibudPeZT0ZLt+c+sAwL4/G+3x9IhRrLj6q
 Z4T+i4wF3z5a7NralfDgGyJ7Y1N+z8/ejJYlvvFNwPPmi0TYGdtktOqpVm0PPHJIogfI
 WeBA==
X-Gm-Message-State: AOJu0YxJ07kWHUg+7SrBsMy9ecJ/JGe2hN9jsPVoUpep8Jp3c90xayOv
 Upj3q/o6JSIPDtPGaLzx//oQEq+yWkocrwRfRSaIDXWe2OV+83S/RyHU+gfhSbY=
X-Gm-Gg: ASbGncsofOkVhr5lMIh4ASQEORKeJAh3IgzbJMVwSc0mWm59ZMvCrezcCCw1jV81hYN
 GK396bUJWDNLt96+HXMMlIXE9KNCn5gz/4fslK28IiIZz8X1dYie7HcobKirgPGRTKF19m1fY1b
 8w+VNUu8E54u8xPNEQJeaU6SaQCYSJl7aepGrb8n8GZvBOQqjLwlYbQ7659DwyT53Vv8sBln1At
 Tc1hjrwZi9k/cyxG9nRT9ifOB/IjpB98D3Cq/89GlUlXPdWmTvsamFMUzTEhycTcwHW1gFbybwf
 Q8tKeqsAGB/OdF0=
X-Google-Smtp-Source: AGHT+IHGZwVaFRdXQC11QqPLloIhv+zw5GAthL0Hn/u+6LQKg/faLwnQeltDQT8RJlyUqR5d2INBhg==
X-Received: by 2002:a05:620a:40d2:b0:7bf:f916:faed with SMTP id
 af79cd13be357-7bffccc7840mr2996101985a.10.1738613380900; 
 Mon, 03 Feb 2025 12:09:40 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254814192sm53895396d6.37.2025.02.03.12.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:09:40 -0800 (PST)
Date: Mon, 3 Feb 2025 14:09:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH 21/32] efi: arm: Drop exception code when running as an
 EFI app
Message-ID: <20250203200937.GL1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-22-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zS1Tlr9j0lQ4mu1d"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-22-sjg@chromium.org>
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


--zS1Tlr9j0lQ4mu1d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:14AM -0700, Simon Glass wrote:

> This code cannot be used since EFI is in charge of managing exceptions.
> Drop it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  arch/arm/cpu/armv8/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why is SPL on in this case?

--=20
Tom

--zS1Tlr9j0lQ4mu1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIoEACgkQFHw5/5Y0
tyzuRgv7B3UVPx6cW/8kqVu6rCVjOkbMe7oCf/6V4TFxRQArgUiq7pFoeJNJYz9y
c8n8ae0A/4mwhslUinHHWouvFQ0F2itz4Opg+S7XsjNSBXt7aPp+FGfwPKV20usp
1MwlNiwbCW3cD1fyUUYILBsAJvqb0xX/IdzNn0i2Yv6vQczbOE54h46XLCt+XNsQ
IV+Ujz70VsosnQcTRRPFHxo7d4pCYMbAKznK/K2wPMhmlOaIhaDousgZiliChi04
NuvuzAYTs+CLNdeqxLTGgEXxa7XPbMTZMQqoEkqx88cBB1DFcBWgnyo2wFjAJmLP
5Ik9pEBBiHy+z1lzKoTevMT7gXhAfK8xMH2qO5pmdHxykJ4/wOn5izgZOOy6jwbl
SWORg7rsUA1jh/hGIcmtTzpiPQyf/DAFglJinP1qMuNtFNFJFU02XgmeLNb0y/yo
j9Oo2523dzqx7wbBENJhhduNhU3NCsvGOeKdM12OzaTpdSn6gO+66TwiKvEqcRl1
JyygdNPc
=9ERe
-----END PGP SIGNATURE-----

--zS1Tlr9j0lQ4mu1d--
