Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20053CDB477
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 18:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F2D086CA4;
	Wed, 11 Oct 2023 20:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PqV7X+OB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E156F86CA4; Wed, 11 Oct 2023 20:36:21 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B1CC8082A
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7ba0828efso1800087b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049376; x=1697654176; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pJMvLwB4hoWRrcFPy9xYpE4/k3qKhz6VZfm0tBUZaa8=;
 b=PqV7X+OBYFGUP9rPOjxF7afNNAl6TIYUBMaVywCHIds4MQuqWLZ6qHuKP9Mk/fMD48
 xD0pk+zLsZmXod2NacFtBDA7YocDHiXavXbA93uJ6S2vsWI0ITfc9Ip+yQOJySVsyPY4
 PuzH9rUsAC5jA4hp/CYWKZe2cOmfnA3/6RM+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049376; x=1697654176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJMvLwB4hoWRrcFPy9xYpE4/k3qKhz6VZfm0tBUZaa8=;
 b=c9I9et+oTp/FYZzseLVGQ/6q6FLkz3ukixX6LcICdy0JLIFSaH+NCfh9TAtSza6ddy
 V30VuwIuXXsEnNwl9aEdVcbWlbumoyeS2oHoGzXLXtcL8XRQqf23WnzI85fYd4TIOWDn
 xvDac50PkR4fL2UuEDXzxpV6bPvFpB4xqMuy1yN1IqkAhubD0P0q3KZbs7LbwJKXsYb6
 p51lzSC1K1cn8jxHdsmwQ49ZgHoBXGxhKKT1rwss8koAOt0PPyw5Nu1uG7fZidiHudnJ
 QAhLMoTkKbdac0Lk6mqGKWggswqUS7qsNCfjKib3aeXYngBQl+OY1K1ufgwhaVtNAtOl
 tzOA==
X-Gm-Message-State: AOJu0YwsTBtgpjLwolleGpEvfWk+GwEELhqz/OYaGrDyvhZjKy4NXC9j
 JpDI0eomhKZX0RUJMdO5ETI7OQ==
X-Google-Smtp-Source: AGHT+IFqN32vNqRSVEogmw308s/61sjpc4dgpiXMm521zJyYn4JT5SAdpc7rizi1lgKEaoNyGng6Yg==
X-Received: by 2002:a0d:f381:0:b0:586:9f6c:4215 with SMTP id
 c123-20020a0df381000000b005869f6c4215mr20775078ywf.33.1697049375955; 
 Wed, 11 Oct 2023 11:36:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 fd13-20020a05690c318d00b0058c8b1ddcc1sm1693807ywb.15.2023.10.11.11.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:36:15 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:36:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "U-Boot@lists.denx.de" <u-boot@lists.denx.de>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Han Xu <han.xu@nxp.com>
Subject: Re: [GIT PULL] please pull fsl-qoirq-2023-10-10
Message-ID: <20231011183613.GE3119521@bill-the-cat>
References: <DU0PR04MB9417C7029385E9026624DB9488CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IVvT4gaI1oNR2qSU"
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417C7029385E9026624DB9488CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
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


--IVvT4gaI1oNR2qSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 05:41:15AM +0000, Peng Fan wrote:

> Hi Tom,
>=20
> Please pull fsl-qoirq-2023-10-10

Applied to u-boot/master, thanks!

--=20
Tom

--IVvT4gaI1oNR2qSU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm6xoACgkQFHw5/5Y0
tyxpuQv4v3v1+o6/e3zY8Tz2AO+YtpBCJ4RIqfVP30jLnz5OOYQP+IkcFbzPeuey
GOMeFji4wKTLDBtY4564mCbNFKqrqaNYC4Bqw6Vj2DA5HZdkpucA0OfLzNnLTXrH
LOl4N8NlPAIEsEXujMiLmaxJBXylv7uH4XPZ4SbRkK1F0vZ/m0ymHqcQTj0PCPTG
zoZGW4Pg7NnU14qTjWi/hD3T1ilvIL2ECp5d6c/zVpM6ccCipsfnCB2ArbpaOHfu
UT4pMVyQbyV1+23+vlRG9xB8fm/ze+/kXHsBTStsqj8eEjlZAQTTe0U83sFUjsXu
U4fSD34xcGqgNVWpi1k04t+x2QOq1fIlYFjzLOCjDuscEJBT1an/1doXWD05c6sf
xIiPJkATus1zUlkOGifeqCuMu5DkExMyn4PFfj7IXEh0spC7IVp8V9/byi+hkKPd
keh0odthKa6czUNMxrZJbdMg9x/KreCVsMAZyXiwHYbkknfTrZNHm2GeHFofOGcZ
NCKVXRg=
=00Dt
-----END PGP SIGNATURE-----

--IVvT4gaI1oNR2qSU--
