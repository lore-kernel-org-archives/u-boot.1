Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90313C83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 07:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1DC1864C8;
	Tue, 29 Aug 2023 09:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="M6uoM0Jj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EAD3864D2; Tue, 29 Aug 2023 09:44:00 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD28864C7
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 09:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so38325405e9.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693295037; x=1693899837; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PIeNMto0FBhskR/5HpxPZklpML7aTeauwTQYgSK9txw=;
 b=M6uoM0JjOxvr5IrdvXDJKH82SX6Za5H6hlafBjBWbS3si602z/EOIcZx00FF2TW8c9
 AyJDfIgVjcsp0XQSdVL+OPgBwtIi4ueuRX+hR7Zx5ZWfr4YY7AnB6/nDnHE2C8g/szZ+
 LHFuiicccmTxDfMHzRbeCCkmjUxQbWPpAIkuGlskL74bQnp5smyJO6Voe0H/Rz80SSfk
 qgLrwR3MDO0nJs8Dm4Qvo4CFz0zAkOV4i1cQtvFWesmefIQO7oAK4b8/d+/olJ0j1VFj
 NTSUxWCWf5MWKqnexu2JKnHbQKewxh2sm4F7GDpxgoGyoPFQSKlJhLtJhdoq97nOSXut
 fajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693295037; x=1693899837;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PIeNMto0FBhskR/5HpxPZklpML7aTeauwTQYgSK9txw=;
 b=KmFqkkV4lcxbTfxWEzdppZQSylYoUmEmGBfrUiq6ywIut33Cjkb1SU9svWVRUiYvbW
 b/w9MX4wY75ctmIlOZstozLaM/05TpC5KDT4fwN0wyM1TZ3zmTaCRD2nKsvyEh8dNfNm
 n75etBCv/NGiMCIyLGQcIj0FYyA5EpRC+5r+PRYBpWzsxot0bdx91g3bdSEq4cPfFVDK
 0spele7jarYt+kmhKtxXH0TtanVmclSpCIOHsGOniViYwxc3A+U8hzHTRDYyc3YfIarb
 4QRKGEhSbpWBmAaAUcNDGOv0O6KoIqPrvbazDE68jO9nzdLY+o4t8xar3cjUS5JD5Ivf
 KyOg==
X-Gm-Message-State: AOJu0YyVUfRJpRXCvTF5T8JtgM8uxD5SiKMlAPD47WgCSN3GnRhOO1hC
 OmNkmwxSYvry6lsZy+wgdOwIyQ==
X-Google-Smtp-Source: AGHT+IEuNECSWpbgRncz/NyAhaByW5LynTaH3vEKoLy/WmEcMgS7MCllzaQYPKIlpeZZYY6livpRbg==
X-Received: by 2002:a05:600c:21d5:b0:401:b6f6:d90c with SMTP id
 x21-20020a05600c21d500b00401b6f6d90cmr8516247wmj.35.1693295036931; 
 Tue, 29 Aug 2023 00:43:56 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c260e00b003fefb94ccc9sm12971189wma.11.2023.08.29.00.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 00:43:56 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marcel Ziswiler <marcel@ziswiler.com>, u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Nishanth Menon <nm@ti.com>, Marcel
 Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1] include: configs: verdin-am62: drop unused sdram
 address
In-Reply-To: <20230828215037.482278-1-marcel@ziswiler.com>
References: <20230828215037.482278-1-marcel@ziswiler.com>
Date: Tue, 29 Aug 2023 09:43:55 +0200
Message-ID: <877cpeb8ec.fsf@baylibre.com>
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

Hi Marcel,

Thank you for following up this quickly on this.

On lun., ao=C3=BBt 28, 2023 at 23:50, Marcel Ziswiler <marcel@ziswiler.com>=
 wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Drop unused macro. This was copied straight from the AM62x EVM but while
> meant for a second region of DDR this is not even needed for the AM62x
> EVM configurations and has meanwhile also been dropped there.
>
> Note that on the Verdin AM62, we do auto-detect the amount of SDRAM.
>
> While at it also update the comment noting that CFG_SYS_SDRAM_SIZE is
> the maximum which is only used for such auto-detection.
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> ---
>
>  include/configs/verdin-am62.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/configs/verdin-am62.h b/include/configs/verdin-am62.h
> index 7990ea83102..e1a5f5ad44b 100644
> --- a/include/configs/verdin-am62.h
> +++ b/include/configs/verdin-am62.h
> @@ -13,8 +13,7 @@
>=20=20
>  /* DDR Configuration */
>  #define CFG_SYS_SDRAM_BASE	0x80000000
> -#define CFG_SYS_SDRAM_BASE1	0x880000000
> -#define CFG_SYS_SDRAM_SIZE	SZ_2G /* Maximum supported size */
> +#define CFG_SYS_SDRAM_SIZE	SZ_2G /* Maximum supported size, auto-detecti=
on is used */
>=20=20
>  #define MEM_LAYOUT_ENV_SETTINGS \
>  	"fdt_addr_r=3D0x90200000\0" \
> --=20
> 2.36.1
