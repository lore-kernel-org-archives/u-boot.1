Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025A1C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613CD82161;
	Mon,  5 May 2025 17:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GWB0TIQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00E29828C2; Mon,  5 May 2025 17:07:08 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2EFE8212B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2d522f699bcso2231363fac.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746457624; x=1747062424; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HYspLwdEpVXAzMvdx0G5FmZTRAoBZvYbylPnJqxzKRU=;
 b=GWB0TIQcR7OUv+jN0qQNelOMw0zO4ZDFJ1VODpMNZRB1d+0TdPisI0fsfRDnv208XG
 hYhQSqTTjlyea6MjOqrbJHeMHO4CnQVwIObHdZzw71ijVrJMYpeGk5DQ8yPfOF3QXcPv
 5zlEnHBhRRU3NJkIwgzoznd8HzeQDd1dNZ11A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746457624; x=1747062424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYspLwdEpVXAzMvdx0G5FmZTRAoBZvYbylPnJqxzKRU=;
 b=sA+6VgTm50aboKRV8CD0+0kM4nv7SXId3IBxUiuiHZ3FSJNhOeM9H5/He+sbMDewFJ
 Thj+lqxqQSDqFsauxi2fAva/rk+Zhv+OcJWPR4RfXeB20ZetCS+nIRcZ23axpmbs/RoW
 iTH3wMPcVuACE2zgGDGIQ7BqLp/mKRpgTD79Yt+gmRSJHjNyalKBKKzaD3IYUmHlFWcK
 2mRwg0+G3LKlaMb7M6ZHQkMSUQPc571ClxrZk2G1n3seQ8IeJFeBiE/AOhqXfDgCFgId
 vjAFibWJecwe2VI9JpoD5XWum9Aa7+dPHtTnlWtlR7gBEyaBG8ttHUdDXN/cWMkedOW5
 GRvg==
X-Gm-Message-State: AOJu0Yxd9cTFhGLTPIA+JWtSJDwv6nJvr6qgxrPfrv2UvyVRdXd3tIMl
 1bEXkn/Qn+MpBHwzOrBi0VSy6TLFvILjRYAR8MUIUsRkeod4wJp2ekGnZzC3iVU=
X-Gm-Gg: ASbGnctA8WP/JVdUET2pI8a4DRrIdQ25APeVHa14gkqvg6XAZbuK/zvkrlmF0Njw/fG
 yqAOguN4agofa+/8e0guLeYV+6bqIblj9dZgtus3pZwGYec7FGMu2/z2/S4c9gpYk8sFrS77Ud1
 HgUrkI/oi3Fvx3ztyBSBkQKUJVVpBuRXES2Dt/07FkFsIMkAof7Rd3zPZdIXgELbK+Cty4wxJ0N
 aLqdrZQG/T+S8ngXX9gd2aPaZtlqHTWWOjSwGl/wZPWFXFBFof4kfikClMTr7ODo/wer8UqaAFg
 +8huq8MuxuoIX/UieUeSVaToZ03d7l4NmKrI5W9lSCe5mVpSoGkHqwWnRYlJrAUU1LnkQLtT7NQ
 Aiw==
X-Google-Smtp-Source: AGHT+IGRbc6i3mVrWiLc241sjNEcm0Cz3eN8scVTLfWFiruvvx/WrwHIVzJ3vtXK/hgbbLBPDn5TMw==
X-Received: by 2002:a05:6870:1650:b0:2d6:6639:52d9 with SMTP id
 586e51a60fabf-2dae8691721mr4178599fac.32.1746457624380; 
 Mon, 05 May 2025 08:07:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa1207425sm1983004fac.39.2025.05.05.08.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:07:03 -0700 (PDT)
Date: Mon, 5 May 2025 09:07:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Eddie James <eajames@linux.ibm.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 2/3] bootm: Add RISC-V support in booti_is_supported()
Message-ID: <20250505150701.GD5430@bill-the-cat>
References: <20250501131858.2160756-1-sjg@chromium.org>
 <20250501131858.2160756-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JdyKWy/rjCVnl/Xa"
Content-Disposition: inline
In-Reply-To: <20250501131858.2160756-3-sjg@chromium.org>
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


--JdyKWy/rjCVnl/Xa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 07:18:34AM -0600, Simon Glass wrote:

> RISC-V uses a similar linux 'Image' format to ARM64, so add support for
> it in bootm_load_os()
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--JdyKWy/rjCVnl/Xa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgY1BEACgkQFHw5/5Y0
tyz2uAv/VhXsp8736RCEcMrKQEqz+OQgg2Wp5830BYuBkL2qI5SC1eEECIsrSm6x
immGlqDxlhEB8L5zp8dLwqL77AjTBXYjt9a8KQ5E7NOHbw0g1Uq+qkqqeSNEpvDM
mOc+7HMdJIRR4cz3gnrdwx6JxghIMss5u7YK6QupJblQNGEZh2C8OxhwOlv46dyR
NVK1FSK+y2gwwjj9hEmRggXstc6P/DrOyRGjY9FR4jGxg8JRzwM7Ug7DqGRhV8k4
GnEW6zlyfO/dctO6TFAPXWgSWV9UgA7BTJLlhrF3I4A63DKVXB5ZoKhJqRpmPaOZ
2EATbLTDSjYoLGMAiYrNZkUbKY436evYg/VnQ4L9qMrhkx56mpJhX8JhiTRQpPQ+
jyfFQa2bJKoJhZrsjCHCQ9WbayoMTZIYr+CX1CokWzp4cxhvwVLb3KYxEdaK1EpC
GDIvtSnGyAzRVbjbGM1eYpsBYJiSgtKE3jZMobvTUTu8jydbmaDb/gBOiXv0rg9G
4AmUXQ19
=7T2F
-----END PGP SIGNATURE-----

--JdyKWy/rjCVnl/Xa--
