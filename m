Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA30C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B948805D;
	Mon,  4 Mar 2024 16:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hwVu+goK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87B088035; Mon,  4 Mar 2024 16:28:34 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C01088077
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7882d75e766so14222985a.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566110; x=1710170910; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w/ORnAWePVSrntSgOQQY2WVQt6MuMW6iWFfCCC+YX8A=;
 b=hwVu+goKm6AmaGFoRsmjwHMbmU1QVCjW0jU1/lClAfPHZPBmdJFX3/SV+bEDRNffRY
 iIc5PJv43QQOfQn1WE68MS+lfSWtYNLNU8zW5m332JmVofQ2JOOtOKnX7Pg6pDfxwOvP
 J8oEZ0OGInZOeYANMg1Mb1cGNeJF9dqV6NE4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566110; x=1710170910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/ORnAWePVSrntSgOQQY2WVQt6MuMW6iWFfCCC+YX8A=;
 b=WtuJr73hi+KAHgeMdHU8fU/5rvq/V8k/NAhpjhOX77+CnEg8olvwd+QIbafbeRtYmv
 se8zdw7QiqtDlpiMKHJGh2vDNSMUKfGy5poapVaER6BhTudkThmKg3Wa2MRzxoZkbOuz
 nxvg6ZoeaBdqrWzCJr4g9UIlWcMQP/euD0qZfeEc9+ZIoshEApz4USE0tz5gZBp22dzS
 nEfUoD/DV0IyI4uUNCD+145VXys7d1wSSi5ZRR9Zxt+hQMtXUEEJvjAfnV+3CiVeSAh/
 jMPabxcoDf4LTgImIDYtyJN52OlEiFehIg0c0zrESA6rE8tl0uo+XmQF/MvPB2PBkQ8t
 qZEA==
X-Gm-Message-State: AOJu0YxQdOnjkA9bNB8Oeeyp41qTswd9aX5CJxBPHUVLWDWux3fSdIb7
 zqkwD0MbVin8RMaxGfUMaMS4gqRPgmFw+coeeluDNur/0xSuxySZ4jyorSEuMs5/DxOPNTmliLZ
 Y
X-Google-Smtp-Source: AGHT+IEydobwFehg12TG4eHSRdHbmmbF4yUXpLbSC7pkPKWjYs0l7ksnYLLzyIgjIifbTgErF6I6Ww==
X-Received: by 2002:a37:de19:0:b0:787:c6fc:db8e with SMTP id
 h25-20020a37de19000000b00787c6fcdb8emr8078852qkj.22.1709566109962; 
 Mon, 04 Mar 2024 07:28:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 pj36-20020a05620a1da400b00787fd080d28sm4293720qkn.74.2024.03.04.07.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:28:29 -0800 (PST)
Date: Mon, 4 Mar 2024 10:28:27 -0500
From: Tom Rini <trini@konsulko.com>
To: belouargamohamed@gmail.com
Cc: u-boot@lists.denx.de, f.lahoudere@technologyandstrategy.com,
 eugen.hristev@microchip.com, dan.carpenter@linaro.org,
 BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: Re: [PATCH] net: macb: Add support for fixed link
Message-ID: <20240304152827.GC1523872@bill-the-cat>
References: <20240206190402.15966-1-m.belouarga@technologyandstrategy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tZMgHAzV2oHv7KU6"
Content-Disposition: inline
In-Reply-To: <20240206190402.15966-1-m.belouarga@technologyandstrategy.com>
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


--tZMgHAzV2oHv7KU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 08:04:02PM +0100, belouargamohamed@gmail.com wrote:

> From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
>=20
> The actual driver does not work when there is no linked PHY. These
> changes add support for fixed-link feature in the device tree.
>=20
> Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>

Applied to u-boot/next, thanks!

--=20
Tom

--tZMgHAzV2oHv7KU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6JsACgkQFHw5/5Y0
tywshAwArQAQTqXZwfuYCLdniL/9o1tGj1uausDfWY9W4yQOeMj66TIQtvEbkpDi
B3USDUtkPPmMScv6AZfOyZjz80124GZw2VvV35YJJsx0vas56xhJZbOoqLxJyX9f
3ExV8CIYA2X5LpZ/PGUGfTOsuoCGaGEtGDaiQHslsY2bnMWKnKXQ8rOB7DnFW0c0
08pzQ2Kj4pgSgL9swggoqdktU3gm1PQKtjObDIfoWQOzQna1XMHg1xSK8Tm4rqp8
Cih9SfwJ58nRhjUPgf3Jm6iSS3xEfP3pqQT7Q13pDYyXhNqX8yPXRd3eycYOcYQP
indNLpK4lpM+omOVf9HEMI6JquxRwcSuIteiN0VcxJNCGE6OqSK1R074er0PvL+A
aubxGl4adwTPu9zb/oVVw2K6Y85cNxYCYCOxEI7I82327Fuyq6vKz4n4bDhvjd0k
j+AXzD48wsYmWUMiibbvfNFmvm57pm0PA45qtWRpfLUHsGZUbY8VpTcKgqGmusHJ
Ejv83whf
=KgtM
-----END PGP SIGNATURE-----

--tZMgHAzV2oHv7KU6--
