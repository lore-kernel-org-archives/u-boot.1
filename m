Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58482C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 20:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A566587B0B;
	Thu, 14 Dec 2023 21:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mdQYdVlG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5A9487B25; Thu, 14 Dec 2023 21:43:55 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C56C87A76
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 21:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dbce6056e85so1034319276.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 12:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702586632; x=1703191432; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q5ea7G8GvVu1qhTBKoRfR48p0A5NdLHJXMVN75gK4ZU=;
 b=mdQYdVlGihs5tfrnd3XQKx7XCxZeJHnE+fmfuDdUhsBG0Eyx1CeEEey7tfGIIJxTuC
 0LgUA3NTZ/t5EwUNKTwO6FozC1zgyS4geHr+WgxlKxhJ6S/Bcijs8KQTM/CFLLmlWVFO
 sf2lAZJEj/pGlpl9Je4ed8yyrdMMJQvYwhgj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702586632; x=1703191432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5ea7G8GvVu1qhTBKoRfR48p0A5NdLHJXMVN75gK4ZU=;
 b=BGnmlL6SYttlwLkYyMROJsNEa7pKrt0Pnx+C6un1pd2xKLcpLSx+AVoDmvDuaor7Ut
 ZHwoxeb3av5bVjkxMfOOc8SzIltnsWus5dmA1+uEEXeknJ4FJOCr9BK+M0MAW1HChiTS
 7htloR4XWfA31SK1lhEOJi0pkc4LECKXVEW1wUNt1zcbYwTugjdS6I26bQ7KZl8e67Ad
 3a/nQiw4BX9qJ3891erEghI6iU7U2ILROI69QkLWZEqNBcfg1LMMxH3ZVTl3kWZ05eHY
 IXHbPp19kX91fK25mLb5oYk139XPKzgzKpaHqjBb+oqN2+xLLuVeZJyoRspAvEMrGi1R
 cnJA==
X-Gm-Message-State: AOJu0YyudgGCv8hBGFDmbpIb8Eh8P+0pEnI4PHooNCoFJgI7S6lBZYjd
 +i+VmlWzikRZHD3CJdvDM7Uzjw==
X-Google-Smtp-Source: AGHT+IGsZai/OGfa3y5avI3CzDvicw+9qM6JJP9nz7E6NBAosTrETLH9lfchM79VS308JClxJPILTw==
X-Received: by 2002:a05:6902:cc6:b0:d81:97c:c016 with SMTP id
 cq6-20020a0569020cc600b00d81097cc016mr8046707ybb.15.1702586632119; 
 Thu, 14 Dec 2023 12:43:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a255507000000b00db5380fc1absm4252549ybb.19.2023.12.14.12.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 12:43:51 -0800 (PST)
Date: Thu, 14 Dec 2023 15:43:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2024.04-rc1
Message-ID: <20231214204349.GS2513409@bill-the-cat>
References: <b60d9dfe-cc17-46b4-8fa8-dffdb8651812@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w18ty+XgnWVG7wQm"
Content-Disposition: inline
In-Reply-To: <b60d9dfe-cc17-46b4-8fa8-dffdb8651812@amd.com>
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


--w18ty+XgnWVG7wQm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 04:50:53PM +0100, Michal Simek wrote:

> Hi Tom,
>=20
> please pull these patches to your next branch. There is nothing
> controversial from my point of view. The biggest change is to create new
> kria defconfig to target couple of boards based on ZynqMP. There is going=
 to
> be work related to binman to start to composing boot images and especially
> FIT image with dtb+dtbo together. That's why I am expecting more patches =
to
> come for 2024.04 but I want to clean my queue now to get these patches for
> testing.
>=20
> Thanks,
> Michal
>=20
>=20
> he following changes since commit be4a5f7c35685d228b3abc398a8d86c434274de=
5:
>=20
>   test: bdinfo: Handle systems without getopt (2023-12-10 10:08:30 -0500)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2024.04-rc1
>=20
> for you to fetch changes up to 4f340244b974d52c48e01cb845cfe8315f7e5764:
>=20
>   clk: zynqmp: enable topsw_lsbus clock (2023-12-13 16:48:15 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--w18ty+XgnWVG7wQm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7aQIACgkQFHw5/5Y0
tyzp5wwAmu+c5nDf9Kg86bO48Fu7blCjYjFbebaEm2FftE8hGcy5W/f0Lca/2WLg
7svYLEWyP17jOKURsHzwe+fm3otsOAB9oDxNmsJ9osqabII8OpKEDspNA+hMwt2H
4h3We7LZkYYUrpPEhutLcBmlat8XlycAl4PwdZnh0d+L/2HUoop+aaTK2hLedZ9p
SebCOvWaFGXDhnDTZnISjSXObBZ0L35k/WC7PiKJCUWQ4Sv8nJ0jsAyulfe/B938
hliQdDhMeZ17f6pcKDzjy7gHfTD0rfxaQQ1ekFWeGn4p2gDgnXl1x/Jd4iO0yLij
ki019WTY30p0TBssAY0OTqNE9cCsM3FUorYzB6YEqu5ttxRbs53wxcWtpVAUGDsa
U1klStrktWRR5xpRiOKLJolP0xwoI3DgqdggvWCdV8YXdI7cW8T13WFI4LZeAiXv
XyOEpZFMffchIXfeIqhySHgZo61N8Y4k+rHJFhIcHUs0xedggQJFD5UKrwRxI2Lg
OTgyC+8E
=Bliq
-----END PGP SIGNATURE-----

--w18ty+XgnWVG7wQm--
