Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6BAC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 06:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E75883C3;
	Mon, 26 Aug 2024 08:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ab4/kQny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E527F883C3; Mon, 26 Aug 2024 08:32:18 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7C987B84
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5bf0261f162so4651046a12.0
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 23:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724653936; x=1725258736;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yARgcnDAtx3Yxw5LFT4MkJfArTZq9+tfuycjr0R/6DA=;
 b=ab4/kQnydZsKCrAYwvruCv0Tyw8GuUA39sMVjZ17TBYF3Ys2jklMCYX29VqqwhVZYo
 tneajlx7wFx7b6ms3gn4cQi/0tS3kTacG4qjr0V7XIv7rXbtwPHIC77KrFoUidHtHy87
 TX9x2A3tneiSmfeoNdYpd/ZGog2AyAUEWqomE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724653936; x=1725258736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yARgcnDAtx3Yxw5LFT4MkJfArTZq9+tfuycjr0R/6DA=;
 b=Ts5f0ZAsIkzEpyrV59WBTxcXSqcoK+qqBAWhcy7D48Ophw+ziyWo7ppZy/KjTHEdMl
 LTYaUzquh/+mf3I7FazvsCCjlIXaMImrHExcdo9GXT3VuyOv4dK9EnlZ6aKSkbVXPvUJ
 xl9IQ6Ge2QkWCs0cOc3Mau9yWegLPCLZa9lWTTKv2D7E8Le3mkXPtUU/jGI68tOn12Ht
 aNh7p/tqdnuhsESQLJGZvEKyFd/IZGdcbnvGcY+FMZH0e7MQ2EHquqX1qX4GYwW2u9Q0
 rF9h9+UFoZLS/+lAnPo4SXi2g7g2m0jdo69BhK+fjBrsUaXGrzWsvGt4kbbGl0tFdqlj
 qD/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDTnUoboP7RczyWz/6vim9WWSWg5wrm0sLMgcMEcUPRvcKL3AkQOQk4d20U158YAw5ar7tFE0=@lists.denx.de
X-Gm-Message-State: AOJu0YyAXZIHYQe1ZOi5zqEChSoq8JP9EofBfGFlj1m/yflrnc6puq6Z
 l4uHnA9etnt+yxmMqYgenIzJOCzPYrdVhtb/cZg1ksefpDmc7uAf59FGs3vo2aljRS5u9t10X4K
 MUtNUZS+1qBDrHcvk2NY+BvD1DTwQGNl3CpQ+0g==
X-Google-Smtp-Source: AGHT+IE3zwHmGc0ADbqzaCBwgxDk71z7sO07GB6/Gdx4SxVW/N9YyZlFQ2D/Pe4EXdbdgQcdfjp1hIHBXwoXMpmGNRA=
X-Received: by 2002:a17:907:6095:b0:a6f:392d:51a9 with SMTP id
 a640c23a62f3a-a86a5178cd2mr652151366b.14.1724653935667; Sun, 25 Aug 2024
 23:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240826060411.3532105-1-avkrasnov@salutedevices.com>
 <20240826060411.3532105-3-avkrasnov@salutedevices.com>
In-Reply-To: <20240826060411.3532105-3-avkrasnov@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 Aug 2024 08:32:04 +0200
Message-ID: <CAOf5uw=GSTTJ_cUpefnFnL+aR-d2Tq6k7odvhqGUEhRrKbcACg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mtd: rawnand: meson: refactor use of
 'meson_nfc_cmd_access()'
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, kernel@sberdevices.ru, oxffffaa@gmail.com
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

Hi

On Mon, Aug 26, 2024 at 8:17=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Move call 'meson_nfc_cmd_seed()' and check for 'NAND_NEED_SCRAMBLING'
> to 'meson_nfc_cmd_access()', thus removing code duplication.
>
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 5d411c4594..19f005202b 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -229,14 +229,19 @@ static void meson_nfc_cmd_seed(const struct meson_n=
fc *nfc, u32 seed)
>                nfc->reg_base + NFC_REG_CMD);
>  }
>
> -static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bool =
dir,
> -                                int scrambler)
> +static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bool =
dir, int page)
>  {
>         struct mtd_info *mtd =3D nand_to_mtd(nand);
>         const struct meson_nfc *nfc =3D nand_get_controller_data(mtd_to_n=
and(mtd));
>         const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(na=
nd);
>         u32 bch =3D meson_chip->bch_mode, cmd;
>         int len =3D mtd->writesize, pagesize, pages;
> +       int scrambler;
> +

unsigned int

> +       if (nand->options & NAND_NEED_SCRAMBLING)
> +               scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
> +       else
> +               scrambler =3D NFC_CMD_SCRAMBLER_DISABLE;
>
>         pagesize =3D nand->ecc.size;
>
> @@ -252,6 +257,9 @@ static void meson_nfc_cmd_access(struct nand_chip *na=
nd, bool raw, bool dir,
>         cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, bch,
>                        NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
>
> +       if (scrambler =3D=3D NFC_CMD_SCRAMBLER_ENABLE)
> +               meson_nfc_cmd_seed(nfc, page);
> +
>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  }
>
> @@ -566,14 +574,7 @@ static int meson_nfc_write_page_sub(struct nand_chip=
 *nand,
>                 return ret;
>         }
>
> -       if (nand->options & NAND_NEED_SCRAMBLING) {
> -               meson_nfc_cmd_seed(nfc, page);
> -               meson_nfc_cmd_access(nand, raw, DIRWRITE,
> -                                    NFC_CMD_SCRAMBLER_ENABLE);
> -       } else {
> -               meson_nfc_cmd_access(nand, raw, DIRWRITE,
> -                                    NFC_CMD_SCRAMBLER_DISABLE);
> -       }
> +       meson_nfc_cmd_access(nand, raw, DIRWRITE, page);
>
>         cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
> @@ -644,14 +645,7 @@ static int meson_nfc_read_page_sub(struct nand_chip =
*nand,
>         if (ret)
>                 return ret;
>
> -       if (nand->options & NAND_NEED_SCRAMBLING) {
> -               meson_nfc_cmd_seed(nfc, page);
> -               meson_nfc_cmd_access(nand, raw, DIRREAD,
> -                                    NFC_CMD_SCRAMBLER_ENABLE);
> -       } else {
> -               meson_nfc_cmd_access(nand, raw, DIRREAD,
> -                                    NFC_CMD_SCRAMBLER_DISABLE);
> -       }
> +       meson_nfc_cmd_access(nand, raw, DIRREAD, page);
>
>         meson_nfc_wait_dma_finish(nfc);
>         meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
> --
> 2.30.1
>

Please change to unsigned int because I think match options type

With this

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
