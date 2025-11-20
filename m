Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5854CF8864
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A643840AB;
	Thu, 20 Nov 2025 17:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="siYNW7CX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3C5840CB; Thu, 20 Nov 2025 17:09:58 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B038783979
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-657509d761dso527750eaf.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763654995; x=1764259795; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UgWeqUVudpHVRA50yRKWdS+aIxnKwxGGHGpFxoxO0gM=;
 b=siYNW7CXfNwsEzRR5V4BfC9uje7k/QgR4/Z81wNc0qFR7XTaQJSaoWtET6CVrM7KbX
 VLTqztCELt8XcOPotC+cbP0urBfA2d+SpYwC1eCmDYny+eOpdj/APoIiIY4Vshp/MT5T
 Qq0BEfjMi+ekzpYo4WECiA34qs/uf8izbt2L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654995; x=1764259795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgWeqUVudpHVRA50yRKWdS+aIxnKwxGGHGpFxoxO0gM=;
 b=T0vhafTSX3sEU4CyyCWZUC9T/OUR1gmknRYxVfN7I3krqo/XOuIKyIz/QK0/KmbYd0
 p9Ko6Nhj2jzjanAhzLVmt3d4hSnnWzdi1Rp84xkT2it2bs9oP8XgdjS6Vj38Y84/eteb
 AU/gvRC+gCnZibBQ6PTGqufN3iCCmAvBWpyFNtCnngOlGbsEDEdInRp/a1+vMXyCMVzH
 ueiMET+Shm9OvoqX8GsH6CCCkcSriRwHY4Br2thDUHX+ysrncJo0tx5dIjcSN0UHa547
 bnz/BJfTtH91Xyt8iiPeTeNpIx3Blp+YzEe7qJgMk5Se8YNaPRkYbHEmb31Lm03HCFWZ
 Umgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY6xFSiVwZcmtXBNp18aTfYwCn+d3bfY9zjWlRQK70Jb/E9Y8RJH4CXOulu4BaUra/PUh/9Ms=@lists.denx.de
X-Gm-Message-State: AOJu0Yxf57s3ZjRf1V83sChn+PIpEEr3WQ0MHIll6xIp1SXnowWwYYap
 EbAwUZWtd5ImQc/L9wCD2xpBwfmJ1CeJUeR5kvCIim1VKX4VQUxG3mpkN1RqNDKGNlw=
X-Gm-Gg: ASbGncsuknw9U92t/wRNu7LGXaUMrwxw60QnoOxTv8KT9+0wtUQ7DgNePkdFaYw98ds
 zxp90Rg4PaOwADg0wsbLeznGnCyPgrAP2bsL1uV4EDCThR3nWQ+ukZzKs14ekK/DtPSrOfH8itO
 sNPfHOTwJ9DSs5CEvFNdDlLQ2PBcUayv5FEnB/ohS5v752RQ3Q1QN35JD5oOhJuU0Ju9NtaAIXq
 Bgh1UN5qmMMUSw1nvARkTQk15HNUt0ul9byDlzYKyR6TuJIu3UqdfZYovdoQyAscvL0NB2ODaQa
 r6Me0HWxkJbEuRDkctA2+xBRprjex4A07GK2NxV4b2A2o+R8N3H5i1/ztalG0TDRYKoc2ilUhML
 Zp7DDgxfaAT8cSvY7rjHPU/y7ja24jQxXGtzreh0qht+VYFaqDS+JfnE6pi6wESr8gV1IGuqY0p
 oeiNVBWoOq6qdZmKiQXtOYmPG3fJppuUa/OgGs3zX8gJLoTOTX/Q==
X-Google-Smtp-Source: AGHT+IFgNfPVdYWl9+WtYb3AXfKOQz7B16raRHE907wTHBuy+kSWspTzIyQEio3YVoctYl6tvQo8dw==
X-Received: by 2002:a05:6820:4c8c:b0:654:f20e:2d02 with SMTP id
 006d021491bc7-65782769f49mr1661090eaf.0.1763654995503; 
 Thu, 20 Nov 2025 08:09:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782bacf02sm815784eaf.15.2025.11.20.08.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:09:55 -0800 (PST)
Date: Thu, 20 Nov 2025 10:09:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PULL] Please pull interconnect-next-20251120
Message-ID: <20251120160953.GK2125796@bill-the-cat>
References: <6bc0403d-cf6e-4955-839d-7a9751c03ff3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LMrnmglHhMei1lzM"
Content-Disposition: inline
In-Reply-To: <6bc0403d-cf6e-4955-839d-7a9751c03ff3@linaro.org>
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


--LMrnmglHhMei1lzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 10:52:33AM +0100, Neil Armstrong wrote:

> + U-Boot ML
>=20
> Hi Tom,
>=20
> Please pull this into next to support the Generic System Interconnect Sub=
system
> for Qualcomm SoCs as first users. The remaining CI failures were fixed in=
 the v5
> version. Also pulled the dependency patch with Casey's agreement.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 96edadab5476c37f3c0b0b99877db16e3e58d5=
e1:
>=20
>   Merge patch series "ti: add speed grades support for AM62a" (2025-11-12=
 09:42:50 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/interco=
nnect-next-20251120

Need to update the .git/config for this tree, b4 pr doesn't handle that
as the protocol.

> for you to fetch changes up to fb3db4aa8df2ae5093a5c1580b9cd5789c248de4:
>=20
>   qcom_defconfig: enable interconnect for SM8650 (2025-11-20 09:17:58 +01=
00)
>=20
> ----------------------------------------------------------------
> - Qualcomm RPMh cmd_db_read_slave_id() & cmd_db_read_aux_data()
> - Initial Interconnect implementation + Qualcomm RPMh support

Applied to u-boot/next, thanks!

--=20
Tom

--LMrnmglHhMei1lzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR89UAAKCRAr4qD1Cr/k
Ckw6AQCfLJwAOdB+dvQ3D2+hRccNEidWjGsOxRDl41xgmzmaAQD/QF7A5Lp1SslY
Dd7WK6NG/KNujBcyqDZPnIeyacI4cQI=
=xy7s
-----END PGP SIGNATURE-----

--LMrnmglHhMei1lzM--
