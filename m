Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A38EC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9C487A0E;
	Wed, 25 Oct 2023 01:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S3jgQpLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95547879E8; Wed, 25 Oct 2023 01:16:22 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02FA879ED
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7b91faf40so50274777b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189367; x=1698794167; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F+yP5SHrj47xmMwWdSeCH+299/ZAJs6dKNSWxNbpz8E=;
 b=S3jgQpLdWZ/lEN6/Rb8u/gPA0I+oQrxGslXkbgSXjuyDSAhXhIIUBjhUFnQV3UBxPL
 56QOuHx2u/ebs6EyEix70gzOfAMh3AQZ2B/jo8N8Mgsk+DCYMqH6bP48iiUQHRyZO18B
 Mcr+o2bD7dMGeRAfvaefsxsvG7rZJ0eY6PlPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189367; x=1698794167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+yP5SHrj47xmMwWdSeCH+299/ZAJs6dKNSWxNbpz8E=;
 b=ww5ORibwq7IUKuTNMRih172+LEirMIdRpWWgPKg+79aacWQl6q/1I88vF4LL54iplU
 kSMgtUkLUvj4e3QIch1Ku4TFD2f9+15kmFtSuy5G9uKYtQz03CgdZxEwjHeLD9zd40HJ
 /a1MV7za7dUjGjVWDdPD8IfgwuHPTkXfM1Op+O3xEM9KvAR+gMKNOfABvVFB7yj+sdSe
 AGw54GtZbQ3UR6feIOFQwgdCoP3JYyGgbeoNgeNRVdM6eas7ZEVoWTve06d0jry9Xaoj
 CZ5pkDyn7m0iccKA+Ntth/wOcu8GMSRreE/sQjjm2Ilnlt0tharOU92hujKwGZK2SK4M
 RNew==
X-Gm-Message-State: AOJu0YxPmCZEo2Qh4PvgW5xyQEcdfAY1aDeNDbZDS2gFZSJwOj2BtmIM
 ce2yKiTrjbPIthRrS0Sv6qP6MCDcLvMZj6lRz/tsQg==
X-Google-Smtp-Source: AGHT+IEtnxlYv5M5M7FwPH/kx5tnwFLE8UHy+19jCzmsDydwjuggVlmvxSujRy74mZiaBVuFKif7fg==
X-Received: by 2002:a05:690c:f11:b0:5a7:d937:6f27 with SMTP id
 dc17-20020a05690c0f1100b005a7d9376f27mr16848609ywb.19.1698189367439; 
 Tue, 24 Oct 2023 16:16:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a81a213000000b00594fff48796sm4440502ywg.75.2023.10.24.16.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:06 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:05 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 5/7] microblaze: Remove common.h usage
Message-ID: <20231024231605.GS496310@bill-the-cat>
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-5-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bh6qnToocDXqqdQd"
Content-Disposition: inline
In-Reply-To: <20231012230359.2005249-5-trini@konsulko.com>
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


--bh6qnToocDXqqdQd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 07:03:57PM -0400, Tom Rini wrote:

> We can remove common.h from most cases of the code here, and only a few
> places need an additional header instead.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Acked-by: Michal Simek <michal.simek@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--bh6qnToocDXqqdQd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UDUACgkQFHw5/5Y0
tyy3Pgv/Sx1dWRtbyrgw6zQCALpPNWLNXBs6zEhmcIAfB0dOdCSX9tAjme84xhNn
3lBDt1WPH8BDUsAmmSpKHdChr22RS0d6XbkQn0S2KWOvYWUzGweTtgDhbOCTDgxL
iL/stuqw2PoXdiMrJJCR9UBk8kmin3IRDVDOcr6xV7aLMPvljcTPdJoBS717uuMB
QePSFWUl6G1y16kH8fcdIr7+dAuMFZHGeQoCtEOKMlwVDOEqOeMJqNK00G9lCM7F
DhBQwIkx+ripXJXvVRGGKhnX5H7FP8HLu2bOKHgbpHJATDIkt35tzn+incACJogh
e8YQRKnYBxjL/J+ZrfphAAD5wOmt0BLANf/6GzKBFvnnPwkS2BV1VXvR/7uWWY5j
vHMohqjRUO/Rjq6+6R0DwPnRrjmG1nvER6U1BJ4qW4d/046jhI3Vyk5IEDOjx+0t
Bb/qR2aIVI+mzICAqGGDTsyPjUakt8/7BdlBdAsh85rYzGrAgjGs7YbndU8fT0fR
I0EB70Gy
=9k6Z
-----END PGP SIGNATURE-----

--bh6qnToocDXqqdQd--
