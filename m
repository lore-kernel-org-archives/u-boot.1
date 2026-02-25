Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B7FFD3763
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F1783E83;
	Wed, 25 Feb 2026 15:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M0SL+HI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6BA83E8E; Wed, 25 Feb 2026 15:24:04 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE5283642
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4c4b494fcso4025510a34.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772029411; x=1772634211; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/WGyZ2aZVfsG7nsRg/lQqw2NjinEEBWfQgGiyI3NdGg=;
 b=M0SL+HI5yMMgMDN20hz7/MtfIJkcJEM1OOc4KMFhClYk2Ujjbalz5BUGWVcqrQWpo4
 XGm3bExmMcGirarERNm7684y7czRDDEgD+sbNSpbZDNOR9/2NAIuogEGQemmB/xqxSwA
 OLKZJWHMAMB83cWK8J5GJDtoSQV2lxpqwTz38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772029411; x=1772634211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WGyZ2aZVfsG7nsRg/lQqw2NjinEEBWfQgGiyI3NdGg=;
 b=it4eg9fyrieiSypvuVr17YwJf4WM6Rw2cawVFqDZvKNE9jIU4wkwL3StlHxTaLO0Un
 irUnhUcDslaFlZCHPYx8hwbLZhii4dNia5tF47nISQOeGPNXj6NrQwtL7vgxLXV2Zf5i
 JgISuLvTJ+t8nkYoL+fr8d6hxde5yDVjU/a314Q39n5FScCN88sTKKxC9XsuPFPbwqFG
 RKqmQCs7hwaB4KRI6dHBIMABkcM09YDDpFPIN6AthS8nGkMK7/J1yGXJlEC5d/zccKx7
 Qq4X6p1oDGyrd6zdFETlWeaMASmpX9la2Gzl2lHklijT1aOn6SRxNZ3NS4WffF348rAq
 0yxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxQTrIyALzeuB7fgGlqi6wr4aco3NwRi1mPi+jEPziDkH4gM9AJFm5cGIl22Duj2mJGx2voHA=@lists.denx.de
X-Gm-Message-State: AOJu0YzK4XRtwdH1L3oq2pClMfohGLS549JxWrfga3nFYPYz862Xa9QG
 dLb36/Yyd4azQ6D/SXb5hG/EwB/o6cRNn/yvNQ1efx7Icm9WAiu/D+r6PKvaD3SDWkY=
X-Gm-Gg: ATEYQzyKS5oQf8rGpv0xJ2INhI9mStE+xHkij4cvv8uj/p5HjTllR1WoIHAqLK8C507
 clwXvBqwwSNsPUSXWLZN7owcOSariWHfom7wfBndZRm4U9XIv8AMzJpzLvNMpgCRHNXZcZCZbQo
 NVP3qOG4Q6zhuKG8C+PSYeMrHkS951Bd1EcWwhHFFArLQolDxW9ykP0FmcgjMdMGRVgvsDOStnQ
 9EIZESb23rum5NQyHn6pn4h4+lUb43Wq8rWRMLBO8qvbv+4VgqQ4z5kkZAR/DwlraXWTeUV0Iyw
 bTC6R3ftTstwI6e982adXE39GoSTM5xsMHGVrA3FMB8MHZyIsZdLJffq1pVQK38IYTU70Tt0gu6
 fYd8hGZY4Q/G3uglN1ddECLxrYZ24lX9vQKUtDfXaKvXYV9FdJUhzrbBRzlnDh/9ws+1pXOFzPl
 A9QhqHz9J4aAfp1vGjikuTJsl8IgykPJysXX00H6+q9Uxh2WhHl0fKk+g1PffTf7+6gxUJTZ/Ff
 gARm+4NpbVtZ4ZY9sl4e6pqtG3nZjuQSCQlPs7lZ5GYCGRIBak=
X-Received: by 2002:a05:6830:d8a:b0:7ca:c723:6f42 with SMTP id
 46e09a7af769-7d5829fc7d9mr334797a34.10.1772029411295; 
 Wed, 25 Feb 2026 06:23:31 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf9f663sm11746843a34.11.2026.02.25.06.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 06:23:30 -0800 (PST)
Date: Wed, 25 Feb 2026 08:23:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: lixinde <lixinde@phytium.com.cn>,
 weichangzheng <weichangzheng@phytium.com.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] arm: don't select non-existent CONFIG_DM_PCI
Message-ID: <20260225142328.GB1593142@bill-the-cat>
References: <20260225054337.12488-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9s0Lf5NNZnmc+NEf"
Content-Disposition: inline
In-Reply-To: <20260225054337.12488-1-heinrich.schuchardt@canonical.com>
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


--9s0Lf5NNZnmc+NEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 06:43:37AM +0100, Heinrich Schuchardt wrote:

> We removed configuration symbol CONFIG_DM_PCI with
> commit 3232bdf0b30b ("pci: Drop DM_PCI").
>=20
> Don't select it for TARGET_POMELO.
>=20
> Fixes: b9d0f00a9d3f ("arm: add initial support for the Phytium Pomelo Boa=
rd")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--9s0Lf5NNZnmc+NEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8F3AAKCRAr4qD1Cr/k
CgouAQCGW5W+5UCzHyRLQBlFfLKgcmIPv9Q1PVOIJ3tEEOI8RAD9H0nmwztIiVkl
55hHQqmlbiIuIbVhTt/SFN5z3sIwbwc=
=qbsc
-----END PGP SIGNATURE-----

--9s0Lf5NNZnmc+NEf--
