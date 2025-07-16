Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCDCC83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 08:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E52D830C8;
	Wed, 16 Jul 2025 10:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="mURkUHAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1872831A4; Wed, 16 Jul 2025 09:48:09 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A92858313B
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-55a2604ebc1so96800e87.0
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1752652087; x=1753256887;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgP9N6nFey4czJCVtruzsNQ4Geh3LgXegpHKfWe3LTw=;
 b=mURkUHAd4zzoVuvYL9eBBPXooQruYrAvRZC6iUvh4ZIqQwk2LO3XBykBTFVSapPAwe
 NYs9GU0NBLe+TMcQ7TyuebyNqLy1tWcneoFMCrr8hVqLunexoQqklSpeeSjzKZflSovO
 vWfkqxEtjTE6v3jHISyKMbOlXlWJJld4kXUqZoq6VTxHhupcc8GqeI9zWWYx1cTHHFXn
 DOjwGHh0bveVKGhJqachIHG1ZWLgf6gWegCMwRzkJEDuSt34H1qd57wHQ/G5ahsEx+u+
 LlEm9bSp6FIx2oLJT8qkeqbLdhIPbGIgkUR+Q/qec/Ju5efi0LrtWXf/NtmuXhpLITDC
 sYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752652087; x=1753256887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OgP9N6nFey4czJCVtruzsNQ4Geh3LgXegpHKfWe3LTw=;
 b=oVTzq86awWnqQiUybzpJOAi+EUbpTGsa9Upp7tMUV58/WuqxjdEEGZ3k1jnsvyY9z5
 v33wcJlIenfkpM/oJYP3PcuGCRN0KLV3GXzfqTUrtDCC04cCtv5U7Ioaka93PM2oPnPu
 FOW1NLF95ldb75Wcxtzes9+P8SmSNSrW4wUBu6OSnX/PoMIb5eWmpFdQuZIW5hMNHQZW
 uG8cPZMiTRCruIJSVFNC3F3j7BEQ3OQRYJpKoLOKP6e1XGi9PzaQGIIFMP67jMeoS9yS
 hKtVmeGfRw9jfI/c6WjGagAX7UCooWHizxX6+ug/oKqStvkqnrm2jKwRk5lJkz08Eepw
 GQ2w==
X-Gm-Message-State: AOJu0YyjRsay4yRYEdp9Ce+ySUN5eFZknCvsDnSZW1Op3O3bH51zrR0l
 vTdXwKtotn98XBDE3PmvaIqvIgbxPiCvy6o3fpos5zMDMna2cwiS6kj48ar7N/vCRoh5ykyod2g
 RBmZ0r1jeJH2lPvFP2Bx3N2/7CJ64SqZxeS1QyeFs7A==
X-Gm-Gg: ASbGncv9ybz8M9maUEeNdXK04sgLwB5Gi+qvCS5FymTSRRG4DUYzfEPfAXrThlYt1yx
 mpazl3nM/XGY15PVpkEU1vkqmhe8Xr/tisuS1dT9cOh+sOqaAh3QK/lcwuMwAcbGOUGURls+l7v
 g1gobMUSl8XnDPuLAqJ3nwdLroHDJcx5MrO4z5VYjQlVcEOTYEXmRZ5DANPttgt8nCJxJbFHjk3
 p2RDl0=
X-Google-Smtp-Source: AGHT+IE85oLIhmP4T+K4GWAa6UlRBpP0fXVBHvvxOmX1GAtN66MvreGZGBYVnLINPQOXxPiDoJ/45UUbg9lQn9EaVsY=
X-Received: by 2002:a05:6512:3d0d:b0:553:276d:1084 with SMTP id
 2adb3069b0e04-55a23f7feaamr571593e87.28.1752652086611; Wed, 16 Jul 2025
 00:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250701-nor-v1-1-ca3435d582d2@hifiphile.com>
In-Reply-To: <20250701-nor-v1-1-ca3435d582d2@hifiphile.com>
From: Zixun LI <admin@hifiphile.com>
Date: Wed, 16 Jul 2025 09:47:56 +0200
X-Gm-Features: Ac12FXyRK2KWih0NOWHPXSqITj_7e0eiZWeoVmn4mKKx_Enx45mhFXKVxOw85Ss
Message-ID: <CA+GyqeZ+vj0cQMT51=OTTPaya26p-fiwNJLzJqUC7Q1O3NmP1Q@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for AT25SF321B and
 AT25SF641B
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 16 Jul 2025 10:24:06 +0200
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

Hello, any update on this ?

Zixun

On Tue, Jul 1, 2025 at 5:16=E2=80=AFPM Zixun LI <admin@hifiphile.com> wrote=
:
>
> These flash chips are similar to AT25DF321A with Quad I/O capacity.
>
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
> Tested on SAM9X60 custom board.
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index e7e97780d7cdd27104fd7db900b3a779d2188922..18bc6f2f06e9a02594da6ad18=
80489e78458a60f 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -76,6 +76,8 @@ const struct flash_info spi_nor_ids[] =3D {
>         { INFO("at45db641d",    0x1f2800, 0, 64 * 1024, 128, SECT_4K) },
>         { INFO("at25sl321",     0x1f4216, 0, 64 * 1024,  64, SECT_4K) },
>         { INFO("at26df081a",    0x1f4501, 0, 64 * 1024,  16, SECT_4K) },
> +       { INFO("at25sf321b",    0x1f8701, 0, 64 * 1024,  64, SECT_4K) },
> +       { INFO("at25sf641b",    0x1f8801, 0, 64 * 1024, 128, SECT_4K) },
>  #endif
>  #ifdef CONFIG_SPI_FLASH_EON            /* EON */
>         /* EON -- en25xxx */
>
> ---
> base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
> change-id: 20250701-nor-0ee20c630bc4
>
> Best regards,
> --
> Zixun LI <admin@hifiphile.com>
>
