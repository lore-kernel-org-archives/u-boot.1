Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF38CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 17:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F048832C8;
	Thu, 28 Aug 2025 19:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IaHIGXjr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EE983321; Thu, 28 Aug 2025 19:31:43 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71581831D5
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 19:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7454a992f7dso731403a34.3
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756402300; x=1757007100; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FwvT1sFwJbDzeBFxY1mcE8j1x1/8pZMd8ZTJ+3icgkY=;
 b=IaHIGXjr+71oM/+QG3tEEu5KTRxB+fEgTtfAW15u28oKbzGOZs1lat2i2149iaaYVQ
 FqbYafQ9r2r0kmEUTRerW803ZHb/CAu+eE+LA02pF63mk4xg/fKRYETPCqjrTqM6hlaQ
 2wUZA85Theue24JlLmblIMlKNtOXKO/fV//6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756402300; x=1757007100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwvT1sFwJbDzeBFxY1mcE8j1x1/8pZMd8ZTJ+3icgkY=;
 b=GGyVNnIcTOml8X5ZO93ODaUnu1JH1tG65ab6KKy/Cx3atsutVzZgU/29NVN69nx0JD
 iG+/JaZHqlY7yAAbXnWS95UAcfEAXCuruXLb3LiYLgsJASxNdm1iG7EiJ/bJ8l8kjJIe
 IB/l+mGXJgDJmYR6pAHEuVNwXZVPuZrwgOTPPxhztmBYZNPOef5Gy/pXvBQRupujbkcC
 TXJ0mbB4KstJfM9IoIpOPETq99mrM+U28Riil6Na+LWvCaZcGcmX9frZCvoDi6eajHIS
 o0AtiWPnXX27Fab1zbCJjEyslPJk2t/5kuEPA9j+WDPL0PpteA7hRTGWgiMyYjfyGpJb
 XmXQ==
X-Gm-Message-State: AOJu0YwKw8byQ3k+L1QpWJkHh9zO8kAiyUyvSyxPA2ZzS8s0Gv1Fy3MN
 p2Zc/I0xY4y7asP5sQgNBomh1OZWuObudOW4F+mrPBgkusQZ6vN264xfrDeWyB3zivQ=
X-Gm-Gg: ASbGncuWKb21esorVn16XNiYvrmUVkaQF8a/kv7ejOeDgWDuUw+t5uPTvF2Hk7GBwi7
 0Vst/bJSMMH3Cq9dwX5j3l7eTmpOsDGtepBiKiDBaWFQ82L4fiIk2HoAJTKyQFL6YMoS+nY5wWN
 HxjABxzSgcZfEPWu1S/FPvEfZk67BKEC9+Qgebw4wQtQ0gagZS4HEB7KUvlckf8VQcoZxXk2xi6
 lOPhnKIWRaNBciWfIlEhGjBpXz/zXm4Abv35j1rwPADn4sIIPGEaTjtXTJLtRePtSsrYnG7CWJy
 p1vCcPTHXBGFe1ynN4EheB9AgZIMfFWP/wkk935v+ghC4D7Nh3ECaQvnDnaWGb9akVt+4xhRJw6
 8YWhebvlpfXhIdVm9dDOymObh1V7o9vhyZPDGesobnyGzGHxsfeEsgoio
X-Google-Smtp-Source: AGHT+IF6k2Y6ZCSaVfLpTjvJxjXkkLu+oa8knOJdA+pYPR47T2EGO8mLlWMp/qDGisDRwDAxrS4fiA==
X-Received: by 2002:a05:6808:1799:b0:435:f353:a648 with SMTP id
 5614622812f47-43785198087mr11342775b6e.2.1756402300037; 
 Thu, 28 Aug 2025 10:31:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61e1fd98f28sm39590eaf.23.2025.08.28.10.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 10:31:39 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:31:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: u-boot@lists.denx.de, nm@ti.com, n-francis@ti.com, vigneshr@ti.com,
 Jared McArthur <j-mcarthur@ti.com>
Subject: Re: [PATCH] arm: mach-k3: increase max resasg_entries
Message-ID: <20250828173137.GQ124814@bill-the-cat>
References: <20250823080615.1899597-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J9ejzajc/CPW9Mzd"
Content-Disposition: inline
In-Reply-To: <20250823080615.1899597-1-u-kumar1@ti.com>
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


--J9ejzajc/CPW9Mzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 01:36:15PM +0530, Udit Kumar wrote:

> Increase max resasg_entries to accommodate max size of
> largest device J784S4[0].
>=20
> [0]: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j784s4/resasg_=
types.html
>=20
> Reported-by: Jared McArthur <j-mcarthur@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Is this for v2025.10 or v2026.01? Thanks.

--=20
Tom

--J9ejzajc/CPW9Mzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLCSdQAKCRAr4qD1Cr/k
CoorAQD0LmaAsHojw2C7w7ZZlvazBxJB6yisrNHv/MTq13kglwEA8wPHSjQ/Wo1t
eTRRIc0d/bhcSIRToeTbdD+hs5XCgAA=
=n5dT
-----END PGP SIGNATURE-----

--J9ejzajc/CPW9Mzd--
