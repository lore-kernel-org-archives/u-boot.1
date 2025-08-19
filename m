Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC4ACA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 05:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8447802C1;
	Tue, 19 Aug 2025 07:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="etLGd3WI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD12B80422; Tue, 19 Aug 2025 07:31:18 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F3878006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 07:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-24458317464so54261135ad.3
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 22:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1755581475; x=1756186275;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fs+DUxSWn1TgLhwOGwPK8d+depwXe1pG9IkYyAo2xu0=;
 b=etLGd3WI8QyUV6lnX3X0q4eDbApHHi3gn5iZcQayrzqY61nTCxKGuh+Xk6rRVLJvA9
 7NYNFwQ4oLP3tDFK6VmBCkU+M4dIZFnwpoUKkVMZj0ZURO73gbjLUfBhfcClqUwDM1lr
 1l28RjRQQg8PuMAdlQxTW38F5jhAPwq37RX8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755581475; x=1756186275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fs+DUxSWn1TgLhwOGwPK8d+depwXe1pG9IkYyAo2xu0=;
 b=sbvfe1g7JWimitIpMrFVb8xRBVtl3ar85aHkaI0VxlnRViHeztH0jbx18VWbNLpTVl
 bb4PEZAvYlHoKMww9bwqvM1eoSfgHlq9oBM/tjNbYg2yH+NKOgizWJ8t/PTGJsCbKACz
 bIRxRaJv86ef+DYuVydbXv4Bt4XnbnL/rlG9WWOcA8SdErfTvcgnjD4ojDpNe8RLZ24y
 IYSeys/MQAD9phFBEoIpeE59PWP2gfcLsrXUk0C8WGrbtRH2K6QGVqX2+FxZZcvggktJ
 kM1HycU3Vs9IpIfqds5jv+g8I0xcZbdtbUSCzU/I+HE/hQtZN3rl1qjw2PDZq/l7X4fE
 6zUg==
X-Gm-Message-State: AOJu0YzZaJpqGhuEvSm2v6qjVBook5BEqTE+nHVS7/E/9JuhaB9tDdgT
 dkt4efFzfnkshvR5xpm3e2FxElIG4mmMCdWBJACBMKuouQlXZHqkjwVGrYdocL6VdYVIT6nNR2E
 nHbA/i/zSxsDVsCqUjSCpiTWoIgPWOnE1DljBOwZZhL8g/GGgdjZc
X-Gm-Gg: ASbGncs2D7oUf8bIfFDNkupx+oNFfuU2nriRSVnAGz2BrdYGBJqH787lSESwF0+WzRs
 1PVEjeL33QDiPS8e0vfiQGtWNE6niGWjOCe43+1bw7zSOYGpn6Ol6J+VZmBefrcHXE4nrAllKIR
 NTGruZ6Z5ztpb9++WxN/4ihlOXbspr02Hu8mrT/Sf4IZ8WLyBK4TaCjdmB99Tue84qFTR5tfTgY
 2NEGw==
X-Google-Smtp-Source: AGHT+IE9UgVj5rjnnmdWMNEP7yN18EMugipZkO958M9J/jppPIyZsjDrd+UA8xkupFLBkK76GnokPgAwIkCENmppCKs=
X-Received: by 2002:a17:902:ef01:b0:240:3e40:43b8 with SMTP id
 d9443c01a7336-245e055b7b7mr14230565ad.53.1755581474618; Mon, 18 Aug 2025
 22:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250819052204.2628-1-dinesh.maniyam@altera.com>
In-Reply-To: <20250819052204.2628-1-dinesh.maniyam@altera.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 19 Aug 2025 07:31:02 +0200
X-Gm-Features: Ac12FXwmYotNLpS4In8Nz9jvPeSHP4c3VnYIvLCzdupZko8pKOQ4FBo1IYBkgTY
Message-ID: <CAOf5uwmrQEUXNcVJWi0VkfLMLN-jfxu007MN4cHhnQwqkE0x0Q@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: cadence: Fix device assignment to avoid warm
 reset issue
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>, 
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>, 
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

Il mar 19 ago 2025, 07:22 <dinesh.maniyam@altera.com> ha scritto:

> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> The driver currently does:
>     mtd->dev->parent =3D cadence->dev;
>
> This works in Linux because `struct mtd_info` embeds a `struct device`,
> so `mtd->dev` is always valid and its `.parent` can be set.
>
> In U-Boot, however, `mtd->dev` is only a pointer to a `struct udevice`.
> Dereferencing it before assignment is invalid, which breaks the device
> hierarchy. As a result, consumers relying on `mtd->dev` (e.g. partition
> parser, reset and re-init paths) operate on a dangling pointer. This
> leads to failures during warm reset when the NAND device is accessed
> again.
>
> Fix by assigning the device pointer directly:
>     mtd->dev =3D cadence->dev;
>
> This matches U-Boot=E2=80=99s device model, preserves a valid hierarchy, =
and
> resolves the warm reset issue on Cadence NAND.
>


Please add commit that it fixes

Michael

>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  drivers/mtd/nand/raw/cadence_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/cadence_nand.c
> b/drivers/mtd/nand/raw/cadence_nand.c
> index 27aa7f97a45..4771440d1de 100644
> --- a/drivers/mtd/nand/raw/cadence_nand.c
> +++ b/drivers/mtd/nand/raw/cadence_nand.c
> @@ -2196,7 +2196,7 @@ static int cadence_nand_chip_init(struct
> cadence_nand_info *cadence, ofnode node
>         chip->controller =3D &cadence->controller;
>         nand_set_flash_node(chip, node);
>         mtd =3D nand_to_mtd(chip);
> -       mtd->dev->parent =3D cadence->dev;
> +       mtd->dev =3D cadence->dev;
>
>         chip->options |=3D NAND_BUSWIDTH_AUTO;
>         chip->select_chip =3D cadence_nand_select_chip;
> --
> 2.35.3
>
>
