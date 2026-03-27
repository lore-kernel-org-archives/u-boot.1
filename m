Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D6110ED67F
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 14:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C31E983C14;
	Fri, 27 Mar 2026 15:41:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GR6V8qUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799C583C5E; Fri, 27 Mar 2026 15:41:01 +0100 (CET)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B51281E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2c107ef474fso3741076eec.0
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 07:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774622457; cv=none;
 d=google.com; s=arc-20240605;
 b=RjFxLtQ0976i8/xG+XXGXtkrxybgQ9V3NEYlMv/A+gdXtAAymsZkvcO7nBokobKzbm
 gw9FX1+NHPDHj2xIpFTk5Kv3Hzo2lmExzud5VtjFFc9sD6chYYs3/W7VRRRGtARFn+eH
 L1jAdhjD30nS/Pnmfn/Kajqp1EFr3OKZ/ZRr639Ipr5EnaVh04HBfLVhL6IIMqqOdxAn
 IDHj3/bKJhj6V8AuoVAZ0tp2+pJC79kxNQ0proYVFtioy4L0jy95x2OkR5RLb/EYvuqG
 RCGPiFCO5rYhaCbHCy5TL11qrL4PD883Ef7KRZCPAX7mUARP+X1qwfMAhC355V5VGfWh
 ssKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Yig6jTSucZRQ/zI1P5n5Xz7B1xbq4vbgsvTpfotn9KY=;
 fh=CszZ190y7bZLvT5IdRaogNOmBDDSw56bvcURcJnUE3s=;
 b=YBfQrZLQKSpvhAv2ZyPbZHcNtYjo6GR+beKJ+v2sk8xxAYTgTnnUrM1d3LdE4lBpgL
 j1IzDPBBfIFCVnRy9DjbF3Dr7TG/SMyxorZkU3+OZwWr1r9J6pCGgbtEL8qEMl+HD7gz
 tns+EO+uZdJ3VWL/QekV9WrnEhbCjhlZ7pWgSO8Sd+yqmOqkWSAxPbR6AgkriO24Wxre
 GDltu0A1JfdrC9BKibVbbYAYdEfVCqtDBKV3U+OTv8K8GHbz0z28OfxCXsByQzk6uVbr
 y3Ua9zKn3Vxtq41BAJO1+fn9wBdWqcZtoP/sMfx38YLjUdiiAprKCokYEnFJbW0VogWN
 CeCA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1774622457; x=1775227257;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yig6jTSucZRQ/zI1P5n5Xz7B1xbq4vbgsvTpfotn9KY=;
 b=GR6V8qUO9EKQz8/cncA285UaFoSTfHnC3YIzPjdXxhcUZDolwK6WvIUQL1POCLfVaT
 1LUbr2ZswQ6WopsvtCclAVMKz65S047fhVc1pHsJ2prrUaE25GfgJXKKL1BYTkjCO/Fk
 XqU7fedyVQZFwgHrHBimX4YMo2yyFltts2Yok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774622457; x=1775227257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yig6jTSucZRQ/zI1P5n5Xz7B1xbq4vbgsvTpfotn9KY=;
 b=Yz6F/rGUGHD9kL6QJ8Xa4yxDji3JsbCOIMEslSc1g6txEW6kK4JOBkPVA6e15O5A5N
 Yx2bC6tmV9BM6Z6euzX8Xqko6N4HuS59mEy2x+x6CSY3xNZAO2Y6b/txsAc8a+f8nz9N
 yLBljbgXUNw07oeSX391bp6vTtGbZ0cG6dAMBOVkqo7C/+BFXWHuBxHoDOjBPyG89hK0
 m6J7XYqwZtrtvpSURWW0hoUUcOFQEqqFdjJL43VugfNuDol+EJ/f7tJbFgdhhS0DJdg7
 l/zXc2bC5vF0lr1hjsjuuc7CQVWSOYq/3NHQXhDjoVSiO9FpcDJ4+Rct6ZjiA1BcuQFn
 RO3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVr3LSGoLkpmmhVrWhXosaQbdSksCixqMgIzG4PBh178ylCuTi78+DNZMzX09paFaKo8YoCa0=@lists.denx.de
X-Gm-Message-State: AOJu0YysBszrxQIkUh2r2IohqyNud3ITFwnE5lPurITRXnSv8GUdveai
 QT/XDRUGYnvIe9A0RFr76zRFps++iaUP5yzUU9e+N/wtbKlCEfGdiDBtMFwWm8iXiZ0OjiAQc4L
 VaamXNiXdpqMiJrogOhjeKTs1EMR1CK5+EdiwoohFbg==
X-Gm-Gg: ATEYQzxsP286HfpTcGTNpTQEahzG0hEpMHauU4RN0UFKqyB3MPMeYiZEe4enssMHYTF
 DatXjziLhRxt5wZWrWQoZdWmCFjxPjzONMpPJqlHVzsjUJ41qJyO1CkiPpxo/bhfDZrilku9fc5
 XjYHoinxdmqUxiyOEWpV6RnvMUTnECe2nkbB4PJ5cm4WEvZeXf4MD5/W0jh0PVXPa7ZYhFu2s8d
 9WRhv7BJk+pVwPxaSU9ufVvD3ns4TJvqIBrgsTK9IR3OZCocfTTLA/l6H5VYyfHuS1A7eSCTIqY
 p5Db2Vy0RYTZQGmhWBPuxGKetRPYd/5JmGfKYuh/zOd7uZWSBg==
X-Received: by 2002:a05:7300:f081:b0:2c1:55fd:50bb with SMTP id
 5a478bee46e88-2c185eface3mr1503001eec.20.1774622456951; Fri, 27 Mar 2026
 07:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260327140508.3680105-1-richard.genoud@bootlin.com>
 <20260327140508.3680105-3-richard.genoud@bootlin.com>
In-Reply-To: <20260327140508.3680105-3-richard.genoud@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 27 Mar 2026 15:40:45 +0100
X-Gm-Features: AQROBzDFudU9cnIv7yRRlvAlCqbjY_G_o6XKpOvcrt_457owmsw6bEtetNr9stw
Message-ID: <CAOf5uwn5c_fBcf4CqW-0pgu4b2SSJSPo8A4KZx1nYb=C+cqr8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mtd: rawnand: sunxi: make the code mode
 self-explanatory
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

On Fri, Mar 27, 2026 at 3:05=E2=80=AFPM Richard Genoud
<richard.genoud@bootlin.com> wrote:
>
> In sunxi_nfc_hw_ecc_{read,write}_chunk(), the ECC step was force to 0,
> the reason is not trivial to get when reading the code.
>
> The explanation is that, from the NAND flash controller perspective, we
> are indeed at step 0 for user data length and ECC errors.
>
> Just add a const value with an explanation to clarify things.
>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c     | 20 ++++++++++++--------
>  drivers/mtd/nand/raw/sunxi_nand_spl.c |  6 ++++--
>  2 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 91f7da2c5ce5..9fc9bc5e0198 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -758,6 +758,8 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_inf=
o *mtd,
>         u32 status;
>         u32 pattern_found;
>         int ret;
> +       /* From the controller point of view, we are at step 0 */
> +       const int nfc_step =3D 0;
>
>         if (*cur_off !=3D data_off)
>                 nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1);
> @@ -772,7 +774,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_inf=
o *mtd,
>                 return ret;
>
>         sunxi_nfc_reset_user_data_len(nfc);
> -       sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, 0);
> +       sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, nfc_step);
>
>         sunxi_nfc_randomizer_enable(mtd);
>         writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
> @@ -787,7 +789,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_inf=
o *mtd,
>
>         pattern_found =3D readl(nfc->regs + nfc->caps->reg_pat_found);
>         pattern_found =3D field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_f=
ound);
> -       if (pattern_found & NFC_ECC_PAT_FOUND(0)) {
> +       if (pattern_found & NFC_ECC_PAT_FOUND(nfc_step)) {
>                 u8 pattern =3D 0xff;
>
>                 if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & 0=
x1)))
> @@ -799,7 +801,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_inf=
o *mtd,
>                 return 1;
>         }
>
> -       ret =3D NFC_ECC_ERR_CNT(0, readl(nfc->regs + NFC_REG_ECC_ERR_CNT(=
nfc, 0)));
> +       ret =3D NFC_ECC_ERR_CNT(nfc_step, readl(nfc->regs + NFC_REG_ECC_E=
RR_CNT(nfc, nfc_step)));
>
>         memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
>
> @@ -807,7 +809,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_inf=
o *mtd,
>         sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + USER_DATA_SZ=
, true, page);
>
>         status =3D readl(nfc->regs + NFC_REG_ECC_ST);
> -       if (status & NFC_ECC_ERR(0)) {
> +       if (status & NFC_ECC_ERR(nfc_step)) {
>                 /*
>                  * Re-read the data with the randomizer disabled to ident=
ify
>                  * bitflips in erased pages.
> @@ -830,7 +832,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_inf=
o *mtd,
>                  * Retrieve the corrected OOB bytes.
>                  */
>                 sunxi_nfc_user_data_to_buf(readl(nfc->regs +
> -                                                NFC_REG_USER_DATA(nfc, 0=
)),
> +                                                NFC_REG_USER_DATA(nfc, n=
fc_step)),
>                                            oob);
>
>                 /* De-randomize the Bad Block Marker. */
> @@ -888,6 +890,8 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_in=
fo *mtd,
>         struct sunxi_nfc *nfc =3D to_sunxi_nfc(nand->controller);
>         struct nand_ecc_ctrl *ecc =3D &nand->ecc;
>         int ret;
> +       /* From the controller point of view, we are at step 0 */
> +       const int nfc_step =3D 0;
>
>         if (data_off !=3D *cur_off)
>                 nand->cmdfunc(mtd, NAND_CMD_RNDIN, data_off, -1);
> @@ -901,10 +905,10 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_=
info *mtd,
>                 memcpy(user_data, oob, USER_DATA_SZ);
>                 sunxi_nfc_randomize_bbm(mtd, page, user_data);
>                 writel(sunxi_nfc_buf_to_user_data(user_data),
> -                      nfc->regs + NFC_REG_USER_DATA(nfc, 0));
> +                      nfc->regs + NFC_REG_USER_DATA(nfc, nfc_step));
>         } else {
>                 writel(sunxi_nfc_buf_to_user_data(oob),
> -                      nfc->regs + NFC_REG_USER_DATA(nfc, 0));
> +                      nfc->regs + NFC_REG_USER_DATA(nfc, nfc_step));
>         }
>
>         if (data_off + ecc->size !=3D oob_off)
> @@ -915,7 +919,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_in=
fo *mtd,
>                 return ret;
>
>         sunxi_nfc_reset_user_data_len(nfc);
> -       sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, 0);
> +       sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, nfc_step);
>
>         sunxi_nfc_randomizer_enable(mtd);
>         writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw=
/sunxi_nand_spl.c
> index 3a5271b49c36..0d1f060cc425 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> @@ -302,6 +302,8 @@ static int nand_read_page(const struct nfc_config *co=
nf, u32 offs,
>         int page =3D offs / conf->page_size;
>         u32 ecc_st, pattern_found;
>         int i;
> +       /* From the controller point of view, we are at step 0 */
> +       const int nfc_step =3D 0;
>
>         if (offs % conf->page_size || len % conf->ecc_size ||
>             len > conf->page_size || len < 0)
> @@ -343,7 +345,7 @@ static int nand_read_page(const struct nfc_config *co=
nf, u32 offs,
>                 nand_change_column(oob_off);
>
>                 sunxi_nfc_reset_user_data_len(conf);
> -               sunxi_nfc_set_user_data_len(conf, USER_DATA_SZ, 0);
> +               sunxi_nfc_set_user_data_len(conf, USER_DATA_SZ, nfc_step)=
;
>
>                 nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
>                 /* Get the ECC status */
> @@ -361,7 +363,7 @@ static int nand_read_page(const struct nfc_config *co=
nf, u32 offs,
>                         pattern_found =3D readl_nfc(conf->caps->reg_pat_f=
ound);
>                         pattern_found =3D field_get(NFC_ECC_PAT_FOUND_MSK=
(conf),
>                                                   pattern_found);
> -                       if (pattern_found & NFC_ECC_PAT_FOUND(0))
> +                       if (pattern_found & NFC_ECC_PAT_FOUND(nfc_step))
>                                 return 1;
>                 }
>

Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>


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
