Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADD4C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 15:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206AC8171B;
	Mon, 31 Mar 2025 17:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EcLI0VTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61EE08129B; Mon, 31 Mar 2025 17:56:04 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BE7681E1C
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 17:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ff0cc7e323so377224b6e.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743436561; x=1744041361; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zNcWtrxTVSuQO6c1ksRc4gg6U8/qZf6uwOFo48W3fqo=;
 b=EcLI0VTq72wrrSYumqwy/9H5i9r4KI7yPZn+vpMK5XXiFp1DNCJHR9h9klqIryDwHo
 X99Y+m5gE3cx337gI/laOJI/uIYMuJxfpf6bUEnUpINa7pg2q+FEEHx3HChZXtz4PmGH
 hBUeA2B2pWyDJwybEnfhqH4qpgeCJz67XMu0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743436561; x=1744041361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNcWtrxTVSuQO6c1ksRc4gg6U8/qZf6uwOFo48W3fqo=;
 b=kEpGfH3KOwoImceUstiZtQLf/N4WQp+Z97tjB2lZB2rjDOVhEatHqVcnatgC6dkMSD
 j0LM7G1sflkSwTek1JauPUQcbvtUQdoVctzCHYNdup+g+Pb9abgdUJlpiBkIwisOf2ss
 cTtgwmxRMdTbojOjNNFWqqQWRl5RSBc+dZCH2nXrJeWGtNgaFvIN3YT2eHbWbqaSqwsU
 eYpYhShfrrOCJNmunpSKgcBNQCcWWHgTtgeqLhPHi8GR0qIpRosG6TgU6RjNrTO2ywsP
 qZKsNegthoG8+dvdQkJ0nT9+1IEMBNAvS7jgawKFsqCnIBLpbTwg5yV5LAGYpcdvMQkZ
 o2eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIDvbLfGyZ9HGV34EmgmbS2+RSXOLM1+h0FfuJpM2XF5dWeimgX2aoIWE1ftqORJvE4yXZCDo=@lists.denx.de
X-Gm-Message-State: AOJu0YxNfESktxju+WDJxVocmo6YiYKMorFFRS5yTVj8nk96DQfQ9GBW
 0aXyuFKc6VlcOvx4kaTXx4OZJ9biaVNrTHpf+dIOvvVbFlFX+r/M98s/qWhNWYs=
X-Gm-Gg: ASbGncs8gACJbM3/8cv+AKK8Dx44/FSlN1bCngrX3u7s2dRoirA+2xmfeY+GyLw8BKF
 Ahu1/dYKN0+ncNqut5hesOmTlnOIe3kmoqW5ZFdFKx1+KHk+J4kLdoqLUjfxewJ8j/wsLkh1w0D
 yKhJg7jbwocLL9RPeYduvCeLllQ2WzyFmUlR4gR4/erK/AveotBFg16H3rLpBMt8bd0s9AESPJM
 CuXVL7iRoDDPDD23skSdZ9yfrnomXmcwnDJ8Wgo4zFmDHXzpfF+ydfbo25uXKQRrXpp2tdncm55
 mqgB/w58rf/UyCBPmfIwbtJAXlVVxkNhRs3kuAzruMDQ9582kjsSu5mtFSz0QhcO90ZfU9riBGy
 JgaBVIA==
X-Google-Smtp-Source: AGHT+IHfVik5htybdsWR8n3mnJdBy8WkNQLFk/V55hJzdMpNvLtpFohFH61rwldMy/RAncz8PZPELQ==
X-Received: by 2002:a05:6808:16a5:b0:3f6:e059:40b2 with SMTP id
 5614622812f47-3ff0f5a7d04mr4691414b6e.27.1743436560928; 
 Mon, 31 Mar 2025 08:56:00 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05295487sm1569336b6e.47.2025.03.31.08.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 08:56:00 -0700 (PDT)
Date: Mon, 31 Mar 2025 09:55:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 05/18] net/net: fix switch/case fallthrough annotations
Message-ID: <20250331155557.GY93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-6-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2/UaK4oCSBo216Sb"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-6-andre.przywara@arm.com>
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


--2/UaK4oCSBo216Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:33:00PM +0000, Andre Przywara wrote:

> The net_check_prereq() routine in the generic network handling code
> mixes case: labels with #ifdef's, which makes predicting fallthrough
> situations tricky. We had two "fall through" comments in the code, but
> at the wrong places.
>=20
> Remove one unneeded comment (no annotations necessary between just empty
> labels), and move one other instance to the right place (before any
> label sequence).
> This makes GCC's implicit fallthrough checker happy.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--2/UaK4oCSBo216Sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfquw0ACgkQFHw5/5Y0
tyxPLgwAg/LDYTOLgqvsitYgcSlmh4mdYcgL0F170UQGw74zGuzYJWuBWgv4G/MI
rRauloBV+c//JIaw3pQYhY3fjkYNLQXqhnwTCeEqR9KFd1MVa/zyhksivdIczlU1
+OORVfj5Oyl6yTZ5iJi1tZz+zNYTELV1cuaqxxRna2dMYZCaitrTMkDAO4GNPEg/
RnNG1eHmHX1Cw7LkFpyF3M3zXQUIj59yiIjMUA1PNXhPd7+R3GpOGNazT4TH5DVQ
Bhj1B1agC3DT1KlCRFLyLSPODThlFXjDj65DQ06+sCIKeWaJ82IsoYTaU3vDQOiI
nxo2bQaJRjboP6Q2MYMIYAvWo67Xo1iiqMYEvxBlqMGJT7Jq5K6iKjtsDsMxhPaz
6LFxWGZOz08dXj+VXKkO04zou61da5Q9uWKii1c7hdpnvxYuaAXaQTnUFCKW7uMl
DkK57Bf0znzKYOILketSyzmvUOXTXdpxqgp2YaFPmhzQ17eyVnThglSCf75WI6eU
RNZrvEkK
=1FW4
-----END PGP SIGNATURE-----

--2/UaK4oCSBo216Sb--
