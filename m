Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F66C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 16:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 559DE8129B;
	Mon, 31 Mar 2025 18:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nUXUNnUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58AB8171B; Mon, 31 Mar 2025 18:09:06 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 768E081026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2bd2218ba4fso1742520fac.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743437343; x=1744042143; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8Hv1bbDlomh2oV5H0QhcdT5Z63E72EfDqZMWgImeULo=;
 b=nUXUNnUSPQN3Uc3qVAgVOoRCD85xMmlfWUrCjz8kBtPkos3E5JHzw006JXwgmTpGMd
 WUVkUJy3SO2AhqJP1b840GT93H0IsKuhEb1uVmacauUQPGLUE7So5H/r5stmGKjGcwQc
 Cp4unkxuj3urVtBCL1v8rXISf8kUkR1kfyw3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743437343; x=1744042143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Hv1bbDlomh2oV5H0QhcdT5Z63E72EfDqZMWgImeULo=;
 b=dWM+9Th2GV3EynlKXBXCEDdRuQRP9xaB6KHRs4460VrqcWif2GNEyqfCUPjZ2V07wC
 dveffqbnQ4SvVROQQPvp61ktV20sEzy8aDRQ6lkMvIqa86cuD+0WpTQdoFPotxAj7CCz
 UHOWICYlcxPmnAgOrOynq+BuYGzEov/uzyWAc+f53qtP5T9WWypSN3URZGOgQfKQkZA4
 bU+gBlkHY3kUFbUGr3GSQ4F5Pp5JYM3MB1svLObFxtkXhOtqhyxM0bRSzBqPM0ZlJ7kG
 BTzh8wAbVQPdFRkrHauLtMQMuNFFjPmXBpwzKr1f+AYNEXfprA3cvue6YXP6J7hMBCQJ
 zIxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDyOSiSi89tEkfLRBTthLmQSOcipVurYMIM5ck0akl4RrE1e9BIPy0zQLQ3bHURIg5FS3ya94=@lists.denx.de
X-Gm-Message-State: AOJu0Yzg8kewyM7jSyD3vluuc9ckaA+CMsDw78oe363ndmruiD2s6+rV
 +eN3kLmOpkJ3A8UxFEtdaezfxa0D6tCyaAqctty8bEs1C/GtJ/qpWczZLoBfUTQ=
X-Gm-Gg: ASbGncuAhnfB7u00JrQ50kQ2R+zPfqAxle+eSDCZEdHlX3wDZOuolP+3CX/8GqX6rtN
 0NBaN6p540cpcJrO0xORn22Kh9z70vcE/lp62eVjv3c7yjLtkfBLsYQCsoLM4r0DmELAUgMF16b
 ussmfxsO1GIlb63GLkg65xXGqfcrDyIiUn8SQJZf/UPtuHpCYAsoQiROaqL3G9Y9i55Fkvj+Cm2
 CTw9WGLR+F5NwAQKE2/CcrlD2XcJHvtVpdE+e3oeE7b4yvF5ZHSGJwMvCZNlig5PEGqN02DSPgq
 /4d48dehf9yHtUI+XRAsGAbDytp11JfjfYzVAhzG/faAhlSGCmp/3QUNH4lp181GxUcAQDuxpdE
 pkrzT1Q==
X-Google-Smtp-Source: AGHT+IGhF5ZU8ZJKC/D9NVa45FWkApb2hZihnOEYEpriPWBJN7Mqk0pP/U2TikhL79AO780x+vCW6Q==
X-Received: by 2002:a05:6871:82c:b0:29e:80d8:31a9 with SMTP id
 586e51a60fabf-2cbcf477817mr5971281fac.2.1743437343097; 
 Mon, 31 Mar 2025 09:09:03 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a497be9sm1894471fac.15.2025.03.31.09.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 09:09:02 -0700 (PDT)
Date: Mon, 31 Mar 2025 10:09:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 16/18] cmd: pmic: annotate switch/case fallthrough
Message-ID: <20250331160900.GC93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-17-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RWinSCLxYeNmphPx"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-17-andre.przywara@arm.com>
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


--RWinSCLxYeNmphPx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:33:11PM +0000, Andre Przywara wrote:

> The argument parsing code in the pmic command uses an implicit switch/case
> fallthrough to handle the common part of having one or two arguments.
>=20
> Add our "fallthrough;" statement-like macro before the second branch in
> the parsing code, to avoid a warning when GCC's -Wimplicit-fallthrough
> warning option is enabled.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--RWinSCLxYeNmphPx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqvhwACgkQFHw5/5Y0
tyx+owwAh7qzk5iY+MfP8JawUeWnlG98SVLqzYabbDlsju9iJ2Ve5UF9EdaHWn87
yWszk/GuP4hPnpW/IF2Lu6uIDfK7Oi+2lJWsGz6399mbc3tEBz5INxyMd4nN1u0t
ulVeFOv7qKhD+TQkRQ4Dua0VSM520M3lF+56oL91WQbB0JxF7+L7/7z+Zfv4zcde
uTa0/nqxORTZrPUfY7jyR67sNA/rzFFmxLdrNXjAmLqkBOIVG5m0JH9peKFNK8jH
4+opaeaLjUAYAhryggutpz3bP2WI5rdTGOK4H7we+qoqBWNNd18eTmFF4iBOMQfj
MtRIYYEFEYtPScn8Lw16+WeGtahD/CTJrLmWOrL8tpl3GvL4pL5V1bV5vDIwdUTh
Tc2fSXsxRQ6X2bquzZPa6msR8yPDwbAapS4GxOFmGIH8jOSwCpvHsimaFge1jPHB
KXTQQus/p0IyW4vDyAghYeKx6prcS50Aq0ngxLQopCQYNA5omvGwCGe//UDaVKgS
U90/Sb7t
=EoWX
-----END PGP SIGNATURE-----

--RWinSCLxYeNmphPx--
