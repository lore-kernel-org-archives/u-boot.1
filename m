Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FBCC46CA3
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A497E870D9;
	Wed,  6 Dec 2023 13:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="X8ySzzL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 900CC87168; Wed,  6 Dec 2023 13:33:59 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFABD86D0E
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-db3a09e96daso5520340276.3
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 04:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701866035; x=1702470835;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVAPxCJWnkUGiVk6MWohzYwKIrBl2l2dWrUMlukRt6s=;
 b=X8ySzzL0o8ZgzIyylHjYUKBuvgySjR+62SF8YrN6dWfVYm6W+zADQNG7RY86Yoze5S
 azco1Qgl8DgMaIGH8p2MM43mQ1yP8+bZJHh9fqIilBariR74GK0DIcOwd4V5o5ZE/sv+
 VIuBFdzKMlt7Q+4vMbWX6XFajFXDPgIDeo70Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701866035; x=1702470835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVAPxCJWnkUGiVk6MWohzYwKIrBl2l2dWrUMlukRt6s=;
 b=vB0yCwvXU7LLDroJyWheF3EB4Go8Ucyb5JFdUpV+KBATWFgMUCv4ARRpFNzBHcXMbt
 7uw/0xhr02UK+V3Cc1Uj5+d5K0tAwrjcNcchvDeg92KnwrJqXbPKEGZ6obOo5c49qwFc
 N1GdAh4+rLqQkC21so7UPuhyVpvBKoegKj/pHwK3roaviZOh9854oSruGvqjwWTL5Jae
 ZnnsRVTK+/lAx2w4cvO5A34UwvHGraZ8WlEWiD/r1xCxyyK7UmJD+7kNo16InFqgkYCi
 VHCE+qGZdOahsTD4nDt/MRTvwU3aImrS4ID8elol3JVBRyY6N5b+jcp7qyL/Hg+QgGz/
 SFGQ==
X-Gm-Message-State: AOJu0Yz1r3t5EQPwP5rKYqlnN0uZdp8U0AEirA8kGE/uqi3zkwuuhwbx
 rS+Gs6luFUFo6+h8N3ulyZDZgjJKJNa3+LsP2T3HC0DkC9TNYRfefeQ=
X-Google-Smtp-Source: AGHT+IHssVS/bi2Bfcdd+8QBdqlVe5UhoYNDzqqYmFEVXIYcqpANNu/qTwQPCJskx2T7drZDz7E5rGIF3yi879qrJgI=
X-Received: by 2002:a25:a144:0:b0:db7:dad0:60cf with SMTP id
 z62-20020a25a144000000b00db7dad060cfmr551615ybh.92.1701866035537; Wed, 06 Dec
 2023 04:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20230812030731.3711-1-ssunkkan@gmail.com>
In-Reply-To: <20230812030731.3711-1-ssunkkan@gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 6 Dec 2023 18:03:44 +0530
Message-ID: <CAMty3ZCo4NyOo8c7Msn5Ub+B7eTA-MEoFXh7_jeFPVUvVWMyPg@mail.gmail.com>
Subject: Re: [PATCH] Add support for more XMC series
To: SSunk <ssunkkan@gmail.com>
Cc: chiawei_wang@aspeedtech.com, vigneshr@ti.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Aug 12, 2023 at 8:37=E2=80=AFAM SSunk <ssunkkan@gmail.com> wrote:
>
> Add XMC XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
> site: https://www.xmcwh.com/site/product
>
> Signed-off-by: Kankan Sun <ssunkkan@gmail.com>
> ---
>  configs/evb-ast2600_defconfig | 1 +
>  drivers/mtd/spi/spi-nor-ids.c | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/configs/evb-ast2600_defconfig b/configs/evb-ast2600_defconfi=
g
> index 9244654c82..f06c0e1fe1 100644
> --- a/configs/evb-ast2600_defconfig
> +++ b/configs/evb-ast2600_defconfig
> @@ -100,6 +100,7 @@ CONFIG_SPI_FLASH_SPANSION=3Dy
>  CONFIG_SPI_FLASH_STMICRO=3Dy
>  CONFIG_SPI_FLASH_SST=3Dy
>  CONFIG_SPI_FLASH_WINBOND=3Dy
> +CONFIG_SPI_FLASH_XMC=3Dy
>  # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_PHY_NCSI=3Dy
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 4587215984..80d7678293 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -531,6 +531,10 @@ const struct flash_info spi_nor_ids[] =3D {
>         { INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NO=
R_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NO=
R_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_N=
OR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +       { INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_N=
OR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +       { INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_N=
OR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +       { INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +       { INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },

Defconfig and ID patches must be separate. Send v2 for the same.

Thanks,
Jagan.
