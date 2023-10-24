Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278B0C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 19:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B53879B6;
	Tue, 24 Oct 2023 21:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qU5XtT7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839D0879B7; Tue, 24 Oct 2023 21:18:03 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DD6879B8
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 21:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a82c2eb50cso46927517b3.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698175080; x=1698779880; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QCAkpoTgcUurIMYcYQd3BMILU9CTm5X07qag6UjOn7c=;
 b=qU5XtT7LL+eDeEyxwYIn/7JbgJoXg4TtgYuApofWuxImlrsgqriiWW18kzAOJYoqJ0
 ttIVdugE1d6Hgwed9qwYksRCZrS0lD/i9IMpVM3On9KFxVmtM7Dn84IN8hM9jygmY4gP
 E+P7CtATVrUlZy/qNkOAgxuRQn14bTssXC0bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698175080; x=1698779880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCAkpoTgcUurIMYcYQd3BMILU9CTm5X07qag6UjOn7c=;
 b=Zz6S7FSY0ZA/9BdcTOcryjQ/HKl8WrfjpA23bvAHe06cJEC58N86L5gb017YkxyEHO
 XUxKQYEZyIMFcPw3i2K642wBhSCw+aB64L/im9VNC63tpHuBi9HAF9svUPCVsm6DfYZc
 kdTUDBgzWFzT5dDkjCWkhBaAimIUyd9A1Ty29OiWkjn1CBxnt+r2kAz6br8elTPQCJ8k
 Ss20bapglLM04BX9wbaAErMBjVhCPbu7UJRq+KmHEK9MQSxzqrym2OB4/ncaj7WYzhQ9
 Btwv23DLVNQpqLRTKeYm/GhetIuWfEj/gyoUxcI1zTiKdrHpX3aK8jr34NbzcthIVAXW
 6I3g==
X-Gm-Message-State: AOJu0Yy71e7zylAY+7IUHNWoYglwAj8U5XHsbNHDnPt7nnyR2hENaXSa
 mjTZDQxy/y6kJZF/4C26zlqIXg==
X-Google-Smtp-Source: AGHT+IGdKGKQeYuCpkmHYmlwxfkdnQb4hlKFix9CqZcOd5LDZG22nBNL5QITMJEdQlra1ll/d9LPmA==
X-Received: by 2002:a81:6d8d:0:b0:5a7:b8e6:6441 with SMTP id
 i135-20020a816d8d000000b005a7b8e66441mr11916406ywc.16.1698175079823; 
 Tue, 24 Oct 2023 12:17:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 m83-20020a0dca56000000b005a0a57cb089sm4296758ywd.5.2023.10.24.12.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 12:17:59 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:17:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v8 3/8] power: pmic: add the base MAX77663 PMIC support
Message-ID: <20231024191757.GG496310@bill-the-cat>
References: <20231024074110.199623-1-clamor95@gmail.com>
 <20231024074110.199623-4-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BWRFaw1fMSahAXsK"
Content-Disposition: inline
In-Reply-To: <20231024074110.199623-4-clamor95@gmail.com>
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


--BWRFaw1fMSahAXsK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 10:41:05AM +0300, Svyatoslav Ryhel wrote:

> Add support to bind the regulators/child nodes with the pmic.
> Also adds the pmic i2c based read/write functions to access pmic
> registers.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
[snip]
> diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
> new file mode 100644
> index 0000000000..4070235d3c
> --- /dev/null
> +++ b/drivers/power/pmic/max77663.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#include <common.h>

Should have noted sooner, sorry. Please don't use <common.h> in new
code, and audit the include list you have as well (this one looks
reasonable I suspect, all the same, so general advice).

--=20
Tom

--BWRFaw1fMSahAXsK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4GGIACgkQFHw5/5Y0
tyxDFwv+JVMAjRt/TknUWp2gAtF4tBOgirg6A/BsFTMDtUBQnnv9dqvMr9RVl5DT
IZkhfxfcBeRYq5/I5VrRX+M8TBTtl0HgUn3/2woy8HzJ3wmrLqlWvd51o6466Nmc
AdjAvhEWAa0wIXJOIVf28Fe6IdjyJK4U+w49Woz3WU3wLb7Q7L+D8gzRyfo6dY/c
cVSGJ2hq3x2K50LYyP7SKlum+5rfiwH2Tvs/VOXzqF6/GudTABwM82QOIm3AKGhZ
wUzVIT9wYmGL1cz4VBYQ92RCXSQBtCluatxL+cKYaHnNTqf4LkRORrHSJbGHnie/
NkBrMMGyg8pbHp+b6SD/9VVZVvmb1gUmMtQGDm2Gp76mrxjvOosKYKRwh1hEQ6J2
ysvjK9Zz+tIyW5ktd7KoGQD860JMU/jdDUm/xtmPv0yDR9ZHbEG/8UWp3ZBUr1Dl
Dx2YvVjCd9VCwEMM+rE95Kvg6v9KaBZNNf0tdXkfnz1SQ0sRVzUDlTIhIsCZ5IOY
YP2B1c3W
=CfHe
-----END PGP SIGNATURE-----

--BWRFaw1fMSahAXsK--
