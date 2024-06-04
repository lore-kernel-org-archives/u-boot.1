Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82A3C25B7E
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 06:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE8F98844C;
	Tue,  4 Jun 2024 08:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D2skRem7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C964388452; Tue,  4 Jun 2024 08:39:04 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07748844B
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 08:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eabd22d404so5641751fa.2
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 23:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717483141; x=1718087941;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iVEPRZT9iBQ+tREY1ufMOOVTXAwOu8EwNdelG4U48uk=;
 b=D2skRem72adiIIWOHIp1UU+oIeTorMcC6peEc0wegoShZJpIKuDUC/WWrSi3rkWdaY
 qoaLhhEPDDdcuIsrdBm+DDDItX+w3aoLojpUVxtW7MI9NXjM1vEdcx41srHBnwEpcAQr
 q9ri5b7XBX+j3egixwOcqbwCO9JtPYpdDZaFItlglY/jtryr2uC70TaODurcuYXHvhUb
 R3NSEj914lXRROiRpULCC1aPxhgE6cP8dw5o7FTVaAXBau85rsRftfW0I+Gj0KYe2KXn
 yp0mn1mnhxjoQnamjAN5S9Gd+jEooPji8MVS0KbzIl8JDeTTdyUiE0iw2cKHnAOoLFHg
 f1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483141; x=1718087941;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVEPRZT9iBQ+tREY1ufMOOVTXAwOu8EwNdelG4U48uk=;
 b=ofc6H6Rmjk8IIu+7SxN/oO68lwiEhU190446VtMfG0j5sV7s3GzNhOWPWQZA+nzZZi
 2qIocQFCtuQzw4lIdTFsbK1v4fQt869XZi53n+Ww9/4LYhjMefuPwJtSW5mZFZerWZ0f
 2y6qBk/2Exvb72m5vRR8i0FVbFAIhaeX2+0FMt8AkCiHDfTe59tQaoeYLMQ/tqmBOyF6
 mNJWdWXb7vo3DYyE+9qRzRtKIK8i0rdwayFxr35Hce2Ps/JN9UNq+IIYsfpZ58MTYzAb
 xa1WYPUxRAEwjpoCc/ZX6ysC+35UdP/UxrGyJ6K2/B7K5sI8ApY9rUV2xlHu6x9ypB3Y
 aScg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm59WsDIN1xCdT/EDJ72625JXwPa+gDHJyUvuTWQLzV4sk7zV5xioY1ZDs6HERwuaY+WDI5pdyIoGBtaiFtX65QWWVCg==
X-Gm-Message-State: AOJu0YxGjjoYAXqlDENKSH9tZeYUaLeIYF27dgPKYVeBKeXmcBoxIoSn
 +klRAf38tl3KHYIMDjrjaxXBNnPBJ/IQWGlk95U++dzQfptPG314qiH/zBZyef0=
X-Google-Smtp-Source: AGHT+IHJB+o8wwv+xOzkRZKmjYc300lGAMcaetDSxtOCKCXaiNT0BTiYiNE95n2Z/TYzsZDUrtv4Sg==
X-Received: by 2002:a05:651c:1059:b0:2ea:89f6:258c with SMTP id
 38308e7fff4ca-2ea94f86d3dmr69979251fa.0.1717483140765; 
 Mon, 03 Jun 2024 23:39:00 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42138682bd7sm93836225e9.46.2024.06.03.23.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:39:00 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Lukasz Majewski
 <lukma@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] dfu: add missing dependency for SPI flash DFU driver
In-Reply-To: <20240604054425.105902-1-heinrich.schuchardt@canonical.com>
References: <20240604054425.105902-1-heinrich.schuchardt@canonical.com>
Date: Tue, 04 Jun 2024 08:38:57 +0200
Message-ID: <8734pt2ovy.fsf@baylibre.com>
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

Hi Heinrich,

Thank you for the patch.

On mar., juin 04, 2024 at 07:44, Heinrich Schuchardt <heinrich.schuchardt@c=
anonical.com> wrote:

> Building the SPI flash DFU driver fails if SPI flash support is missing.
>
>     drivers/dfu/dfu_sf.c:123:29: error:
>     =E2=80=98CONFIG_SF_DEFAULT_MODE=E2=80=99 undeclared (first use in thi=
s function);
>
> Add the missing dependency.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/dfu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
> index 0360d9da142..971204758aa 100644
> --- a/drivers/dfu/Kconfig
> +++ b/drivers/dfu/Kconfig
> @@ -68,6 +68,7 @@ config DFU_RAM
>=20=20
>  config DFU_SF
>  	bool "SPI flash back end for DFU"
> +	depends on SPI_FLASH || DM_SPI_FLASH
>  	help
>  	  This option enables using DFU to read and write to SPI flash based
>  	  storage.
> --=20
> 2.43.0
