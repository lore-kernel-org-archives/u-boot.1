Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D87CC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A64C8069D;
	Fri, 17 Jan 2025 15:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TvV8vrhO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 360DB806D8; Fri, 17 Jan 2025 15:53:08 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A22C58036F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 15:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6ed0de64aso220471585a.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 06:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737125584; x=1737730384; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TOXVSFJV0Fd6WhgC6xi4JMbtAih8A9mJxRNgmYq6O1E=;
 b=TvV8vrhOaiU82DTqYuIkcNM6LkzZSem8/ZsCJ0FPxMDTNK/Coc6A595Be5Rdz12c+o
 5URFqZK2pwcRTIQG3o3juwLkLO0+3sisKzrDNQnqC5dY3kuvdLTbYT5o77U6XDPesmlK
 7vwNGnU4cqvkkqaTi9sQpc07Vs4yNi+9s9ojQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737125584; x=1737730384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOXVSFJV0Fd6WhgC6xi4JMbtAih8A9mJxRNgmYq6O1E=;
 b=kRV1iAZgEDABmKt8BoiG14qd7lmpsDerYxA4nIZtIEz+KSAuU0HwF9GOOupo3OjeYL
 Kbf4Dg8BQj4g3JE0C6bbFStEVI73ni+2Ba6Zaa0iJ2DDW5GY1VB4FyHGLkBBUXKJygxX
 1X4Is824r/gpT8OGynsg7c3syCCXO8HTmrHdMI0qpjtnsm2sGMc12pUWcRlX9hHvqpb6
 T5UG53O0aSnP3s56mUsV+u6Uyd6eWL63RB8yWEd9W3zaIDOXomwNozUGMH/6iT0zKz+I
 VK2G5VUy/BAVGejx2f22DQH0BpDZ+C+LfjKdbt7upNHPZpSzKir8iU7JEhe8gPl91c7y
 Kzow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBIeCvoIAFhzkXCaJsEZt4FwmRQSDYPWZa6yULs4RVGU7HUmmq9vwW6M65FVIaN4vMj4qIO/k=@lists.denx.de
X-Gm-Message-State: AOJu0YzH817oz1AbSJf0ICtrEp9mLj7jmH8DD1FHUPJvLapMZ4fFTtfk
 +1nNKq+t1IAQ/tD8adHBCTCcJCSv+uNhqvi8IlOXLxJmZ2XrYct4ygomJQCgkfU=
X-Gm-Gg: ASbGncsP4CaSpZAfdxkIAjOBv/BXiQAlbIUUBfUgO7py6yWiZ2TlreBCb6Y/ysAcJeC
 uMvrS6Ey9E22n7jSuZAx4/DsYQiuhFBhJyDY4FVvKuF8ZXg6e83/A2jkq8SMikYAqt1vUffkuYW
 Rc1c04zMfVd8DDE36iL/Lp/BUhIxxqHRFc45bVzxHXAWdzVUYvPiB37I4Y+dZqOC7/vZstUnFtS
 qbNepyN/feYUQF/nICGJoGObZvhdV1W0oDY5VyZbXq1khNyqV6PPQ==
X-Google-Smtp-Source: AGHT+IHdfaUkzEAKegj5Nol3bBRtig1oTaHaKgfYWM94uz4U2Wc8h1RvDvbZRu+AjWYhZzK1417vmg==
X-Received: by 2002:a05:620a:6018:b0:7b7:142d:53a8 with SMTP id
 af79cd13be357-7be63a13124mr464540985a.19.1737125584444; 
 Fri, 17 Jan 2025 06:53:04 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614ef631sm118642285a.109.2025.01.17.06.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 06:53:03 -0800 (PST)
Date: Fri, 17 Jan 2025 08:53:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Jesse Taube <mr.bossman075@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH] ARM: dts: imxrt1050: Migrate to OF_UPSTREAM
Message-ID: <20250117145300.GQ3476@bill-the-cat>
References: <20250117030027.3874367-1-Mr.Bossman075@gmail.com>
 <PAXPR04MB8459F5D8C54A1C406D408036881B2@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zFg+n7fpLEndIQo1"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459F5D8C54A1C406D408036881B2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--zFg+n7fpLEndIQo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 03:22:08AM +0000, Peng Fan wrote:
> > Subject: [PATCH] ARM: dts: imxrt1050: Migrate to OF_UPSTREAM
> >=20
> > The device tree for imxrt1050 is now
> > available in the /dts/upstream directory.
> > Migrate board to use OF_UPSTREAM.
> >=20
> > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > ---
> > Please note /dts/upstream still needs to be updated
> > the upstream commit is
> > 5f122030061db3e5d2bddd9cf5c583deaa6c54ff
>=20
> You might need to update the dts/upstream to make
> this patch in.

Yes, you either need to wait for the next re-sync or to send the
cherry-pick as well, see
https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing=
-with-devicetree-rebasing
Thanks!

--=20
Tom

--zFg+n7fpLEndIQo1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeKbskACgkQFHw5/5Y0
tywawAv/fqMkn3xqjIzZ4nJRgZlOwlZ2qiyI9Zw+00IQewBJUGJm7JSoUp1LMAbv
xyjRsFxzOBprlmSn8jAeZEu8PjMMMkcvBZNzedY661oBD8SpgxGu43+FBJDO20Wp
N7wyYak0MCNW5VpwmGqrS0RXXrvPUTfQvC/4DJdQEEDcUAM+dsylsQG6Qgj4PYjR
qKRCewesk+6GmKdmL+Ji+ChNUF8wlijIhqfbmVJRPIU9du65Q2K8y+Cn4r1TM5kJ
Chs75oTfn8lVU3Y7LFuBKEM1qZpKx+MUCeoNLm9yeE1k6G7a1FYJOQAy9/SV5Mht
MENQ6+Qh6uc8tIpauIxAS9CBYkjjsLk1ScKNpxHTP8KC1kwv6h1pie/U1dRzhUic
MKYi7ixfEQ0p6lXPBf5aLg0LxJ/p8xrTpLHvAMEWu1COovXMDD+MrSV0FeKsoxs7
hDVISLwK+IYEpPiPJjR/cuDrCPZ0qPnKKy8qPE0N3JR8LtYe6GVxthR3hLzy1gVa
S8rgqJq6
=XWzO
-----END PGP SIGNATURE-----

--zFg+n7fpLEndIQo1--
