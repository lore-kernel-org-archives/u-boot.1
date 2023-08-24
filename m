Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A88AC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D488656B;
	Thu, 24 Aug 2023 10:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="eaaEwq7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9FB886571; Thu, 24 Aug 2023 10:06:18 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66D5786548
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31c6d17aec4so1069566f8f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692864376; x=1693469176; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mgKlXgroyumDgO19S5WXpo+1tK4CL8bDXOu0Zx1JFws=;
 b=eaaEwq7oAGIkWx1Ejh4rd+nZ13632Nt7BJWpke4Ae2/h1OIyBbm2wYwVvBxH9be1sm
 Orl7Ojl9x0jwhzXuqLGpcIsvYRK7bXV4AWn/lQt7wkyH51VwT97lSk+N9ISCynArob8m
 Qsko1RrPcfgiojyu2w7OPO58bSrBO3oism2fTwHioOoZc61Wn7pm5fyu6NViD+WvTr2H
 XUn7ckYaHEWxSooFTzMWZjVE9B3EfkW4P3sUckNyfLHxtnXbeL6TA+MrRQ1NbCcisuIy
 qFFEXwF3P95eU/gghHeQrkFgc2tDNYZBshroaVJNx4NasJ7oJZ+3uxNDzr3ecAWKYlSD
 5z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692864376; x=1693469176;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgKlXgroyumDgO19S5WXpo+1tK4CL8bDXOu0Zx1JFws=;
 b=TGo50QWLVnJx2zF6vSXqvICF5qJ1JaRwMVMQlC52o1FPESqfhQVYLgmgset+ojbe5r
 3hQa7vwH2P9GFmT/skdn88WUh6S+f8YkFmK8Goo8xJhH+GkfilaYRYWUBbV/rhKXeR0h
 e76zuQkDP2aHXRE1zsKjxsu3FHTOPDAVQ/omlwuGPvS4pb67gsJ1auOi5oFEwys1XLnA
 QPiZQoI+axORHtJQ4zIYsns2L+5lfR0byWvrwM4RpremAWmCwH2dkTvEghEjJC9GY8x0
 zG+L0FBXfmfmJAmjg/yoDxlQ3JO2oKESeaoGduNu5NStlMagIl5Hf2qJWQn1cSGpBI/i
 Ks6A==
X-Gm-Message-State: AOJu0Yw6TMhmaivg7cHT5g11Cb1mEZhAaHxte3J9J4ozKS80wRZIg9yr
 UundEHHiKOFy5FKX/EfehMYQcA==
X-Google-Smtp-Source: AGHT+IEXw6YpZdWrkbVkVjwrrpBo3mijV1E7M9fm2iMJ03HFWD2/neSGlM4IAcgGYjqUUu2/vmfCog==
X-Received: by 2002:a5d:58f8:0:b0:317:7af4:5294 with SMTP id
 f24-20020a5d58f8000000b003177af45294mr12619547wrd.44.1692864375365; 
 Thu, 24 Aug 2023 01:06:15 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 y7-20020adff6c7000000b0031accc7228asm21390965wrp.34.2023.08.24.01.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:06:14 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V5 01/17] include: configs: ti_armv7_common: Add
 documentation for protected section
In-Reply-To: <20230824031101.3460411-2-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-2-nm@ti.com>
Date: Thu, 24 Aug 2023 10:06:13 +0200
Message-ID: <87lee0rhje.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On mer., ao=C3=BBt 23, 2023 at 22:10, Nishanth Menon <nm@ti.com> wrote:

> Make the section protected by CONFIG_DISTRO_DEFAULTS macro clear.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> New patch (part of bootstd transition)
>
>  include/configs/ti_armv7_common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_armv7=
_common.h
> index dbbeff34ba82..4e30d0d2ddf8 100644
> --- a/include/configs/ti_armv7_common.h
> +++ b/include/configs/ti_armv7_common.h
> @@ -200,7 +200,7 @@
>  #define CFG_EXTRA_ENV_SETTINGS					\
>  	BOOTENV
>=20=20
> -#endif
> +#endif /* CONFIG_DISTRO_DEFAULTS */
>=20=20
>  #endif /* CONFIG_ARM64 */
>=20=20
> --=20
> 2.40.0
