Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4AFEB1076
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 21:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCB3584090;
	Tue, 10 Mar 2026 22:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TqybGocw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AAAB8409A; Tue, 10 Mar 2026 22:22:59 +0100 (CET)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E516D84082
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 22:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2be19f05d7dso229918eec.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 14:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773177775; cv=none;
 d=google.com; s=arc-20240605;
 b=Z2XSl66T8C8/t2BFrq8IATQHhSg9HjDj5nN5jvCXVnfLm5qZM9d9fk3ilYFngNSln3
 ri1OTj3LrDp6tqb2KRGm18OhOwup+ucLBFXR4qa0EBM9I2MHxaA/OYcroKoeY+xNe5RP
 6iPP4VeaLgVZ8MgiblKEkZieXED7SQTYHpsKYxj3vfhQAHHW6jZ6iT67pRX7o7cU3HuM
 W2Dv2VYRjAf2SPqVCMZQ3GOAEwpIfDqHF8y7UcrsDKu74wBfz2mbL/7J0BMORvs4PsnN
 KlFaLzUQRNO4LhQtJCHGkFTDtPELYmdmHSQqzLaxzd2LYB4dBC4a3tOfF2DWRI5/VfKH
 FO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HhPyHhxYmfbey//ncJBNMA7VsC+Wd7FwqkKc4u/DdxI=;
 fh=SyDito5tKWqg8FYhyxmqZd8pgFOKwHAikQJ7nA3tb3c=;
 b=Fw8SEH27hbFs46as+FENDlatnpDulOoiAmqtjgFw2H6H4m8V9ueuBEYyvk9u7N4YSg
 nVDzoA/m1fPssoOFgv5L/xBQXEb4skv6I1QPaeGkQFTwW+Ju0K3pFtNLGZYwxYNs+LNi
 S1oP+xw3HaTftvyj8Bp27r2tqIsc/WyIpaZvDkAgL4d3w98T+UZuw6yqEFOv6CLdZkk7
 FqghDbZe4sJHsUwaktKcHTjmRrWXIbgsm5cFbx/ilwAz1S2Bbo1Z4VZi1QlrwMQRp1s6
 0hKPiFwr0ECnjNsRje1YfD3cYqXb8/bFp3xr+EskTXkPmXWmIZB3CiSUBQbXYpZT8+Rl
 0nnA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1773177775; x=1773782575;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HhPyHhxYmfbey//ncJBNMA7VsC+Wd7FwqkKc4u/DdxI=;
 b=TqybGocwdCFO+eMPm3GJ02bh5S4XZ6W8+ZDl9jvZFPvpQmLQg22JbsUyqe6IVo9D+4
 zm2jNMXz7UQyBAkATdCXfikyW6Wqu+cXh4ru/xe551pIfP4m0dpFxhPY5u9RYVAj0kOU
 Ot5mewSHaGZfdjlLZ9edydvbTC52W6aI1q5rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773177775; x=1773782575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HhPyHhxYmfbey//ncJBNMA7VsC+Wd7FwqkKc4u/DdxI=;
 b=hyy6Eku5T7HrLUJNtNIhrWSclmjUpVDHv7qCYuyhMCIRyRisePbqiQV7OQNWhnaID0
 qI7hmcHm/6vPoFIED3kM5Z6CDMVYpbFrfHE1jof1BIYENPjgkmQ7SnqgnHvbW17kZ28P
 CWAKV3J9sjCa7sTMTi0l56BBsTXTw+mHv2x2x2jmqlw6AUFdZrSojtkn9HZ48UjHFg4x
 jDOqvJFBWuSNThTn+U9ErNcglMEZ/FQ1ecVkP5i1m4FENNZEnXvYcGI4iBV+0W7UPsHT
 4AUlobUhsSZdXfX0dsya8ezBU3+ifrWReJQNYqYCuQmeyOUcg8V4Hx82WDfaF+XJBynY
 lBPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPmi63gtVnUL8Jp1RVJdlMG1Is1G/IjetsmLWCm65nKBTGPgq+6a6WhZ9cJHEFpsa/zY095mw=@lists.denx.de
X-Gm-Message-State: AOJu0YzAVBGj9igz6t9mlOBpBhynZxD+Nm2Ho4V9fyzX6Nfwc2xFvLkr
 Jae0Psy/IZ3d4NhWdZjcgYLW7xBDkqOpw23q8ozsFRprHPx7Y2G+8CYRFO9aSxxVQlnQrrKT344
 rccdpKHjeRjLzNP2KBSrCnn6kW+S/EIfh5sSJIh68Ug==
X-Gm-Gg: ATEYQzxpe2YIPHbS2ikpPESogSD2M6U3Nv6l73VHL1d9jwdcmAiQmvC3AIpjL99SCGV
 4x6DEo4PeLhyR4r/d46xhCMAJ3PnzhC0uhHyH6pjWbeLVB+7ejGA623rmu2IZDctIbg7v79UXkN
 HonCI1m6GPODQxxeygWokLPKf1qUlCk6EFf1WOrSZn1oMpYqk4AT2eUX2jkw8DPgs7orWFWmRlZ
 ab23BBvBADWxkeTVz1cAtalUGC6WSlk6QFMym4M0m7AWxrBb32wRPfKoRTHCMPIr5f5ouOAgN7j
 NLCodVRzZ/SeOb/qrQoUXFZHvKiQz2wMRsoW1Q==
X-Received: by 2002:a05:7300:e607:b0:2be:e4b:60d2 with SMTP id
 5a478bee46e88-2be8a20f82emr109515eec.4.1773177775101; Tue, 10 Mar 2026
 14:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260309152251.70837-1-richard.genoud@bootlin.com>
 <20260309152251.70837-2-richard.genoud@bootlin.com>
In-Reply-To: <20260309152251.70837-2-richard.genoud@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 10 Mar 2026 22:22:42 +0100
X-Gm-Features: AaiRm50IufYgHaIBDcK89Tp_-YFFnd56dl96Pi_QqyU4p-JGf0hYpGz_B1f4hcs
Message-ID: <CAOf5uwmSd_0=-eq2fb2vWbZ7W+wo9_oOqp5BtppAutM=C6tk6A@mail.gmail.com>
Subject: Re: [PATCH 1/4] mtd: rawnand: sunxi: Replace hard coded value by a
 define
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

On Mon, Mar 9, 2026 at 4:23=E2=80=AFPM Richard Genoud
<richard.genoud@bootlin.com> wrote:
>
> The user data length (4) used all over the code hard coded.
> And sometimes, it's not that trivial to know that it's the user data
> length and not something else.
> Moreover, for the H6/H616 this value is no more fixed by hardware, but
> could be modified.
>
> Using a define here makes the code more readable.
>
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c     | 58 +++++++++++++--------------
>  drivers/mtd/nand/raw/sunxi_nand.h     |  3 ++
>  drivers/mtd/nand/raw/sunxi_nand_spl.c |  7 +++-
>  3 files changed, 38 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index ef27a4b7a36a..91f7da2c5ce5 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -772,7 +772,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_inf=
o *mtd,
>                 return ret;
>
>         sunxi_nfc_reset_user_data_len(nfc);
> -       sunxi_nfc_set_user_data_len(nfc, 4, 0);
> +       sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, 0);
>
>         sunxi_nfc_randomizer_enable(mtd);
>         writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
> @@ -783,7 +783,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_inf=
o *mtd,
>         if (ret)
>                 return ret;
>
> -       *cur_off =3D oob_off + ecc->bytes + 4;
> +       *cur_off =3D oob_off + ecc->bytes + USER_DATA_SZ;
>
>         pattern_found =3D readl(nfc->regs + nfc->caps->reg_pat_found);
>         pattern_found =3D field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_f=
ound);
> @@ -794,7 +794,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_inf=
o *mtd,
>                         pattern =3D 0x0;
>
>                 memset(data, pattern, ecc->size);
> -               memset(oob, pattern, ecc->bytes + 4);
> +               memset(oob, pattern, ecc->bytes + USER_DATA_SZ);
>
>                 return 1;
>         }
> @@ -804,7 +804,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_inf=
o *mtd,
>         memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
>
>         nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
> -       sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + 4, true, pag=
e);
> +       sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + USER_DATA_SZ=
, true, page);
>
>         status =3D readl(nfc->regs + NFC_REG_ECC_ST);
>         if (status & NFC_ECC_ERR(0)) {
> @@ -816,17 +816,17 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_i=
nfo *mtd,
>                         nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1)=
;
>                         nand->read_buf(mtd, data, ecc->size);
>                         nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
> -                       nand->read_buf(mtd, oob, ecc->bytes + 4);
> +                       nand->read_buf(mtd, oob, ecc->bytes + USER_DATA_S=
Z);
>                 }
>
>                 ret =3D nand_check_erased_ecc_chunk(data, ecc->size,
> -                                                 oob, ecc->bytes + 4,
> +                                                 oob, ecc->bytes + USER_=
DATA_SZ,
>                                                   NULL, 0, ecc->strength)=
;
>                 if (ret >=3D 0)
>                         raw_mode =3D 1;
>         } else {
>                 /*
> -                * The engine protects 4 bytes of OOB data per chunk.
> +                * The engine protects USER_DATA_SZ bytes of OOB data per=
 chunk.
>                  * Retrieve the corrected OOB bytes.
>                  */
>                 sunxi_nfc_user_data_to_buf(readl(nfc->regs +
> @@ -854,7 +854,7 @@ static void sunxi_nfc_hw_ecc_read_extra_oob(struct mt=
d_info *mtd,
>  {
>         struct nand_chip *nand =3D mtd_to_nand(mtd);
>         struct nand_ecc_ctrl *ecc =3D &nand->ecc;
> -       int offset =3D ((ecc->bytes + 4) * ecc->steps);
> +       int offset =3D ((ecc->bytes + USER_DATA_SZ) * ecc->steps);
>         int len =3D mtd->oobsize - offset;
>
>         if (len <=3D 0)
> @@ -896,9 +896,9 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_in=
fo *mtd,
>
>         /* Fill OOB data in */
>         if ((nand->options & NAND_NEED_SCRAMBLING) && bbm) {
> -               u8 user_data[4];
> +               u8 user_data[USER_DATA_SZ];
>
> -               memcpy(user_data, oob, 4);
> +               memcpy(user_data, oob, USER_DATA_SZ);
>                 sunxi_nfc_randomize_bbm(mtd, page, user_data);
>                 writel(sunxi_nfc_buf_to_user_data(user_data),
>                        nfc->regs + NFC_REG_USER_DATA(nfc, 0));
> @@ -915,7 +915,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_in=
fo *mtd,
>                 return ret;
>
>         sunxi_nfc_reset_user_data_len(nfc);
> -       sunxi_nfc_set_user_data_len(nfc, 4, 0);
> +       sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, 0);
>
>         sunxi_nfc_randomizer_enable(mtd);
>         writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
> @@ -927,7 +927,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_in=
fo *mtd,
>         if (ret)
>                 return ret;
>
> -       *cur_off =3D oob_off + ecc->bytes + 4;
> +       *cur_off =3D oob_off + ecc->bytes + USER_DATA_SZ;
>
>         return 0;
>  }
> @@ -938,7 +938,7 @@ static void sunxi_nfc_hw_ecc_write_extra_oob(struct m=
td_info *mtd,
>  {
>         struct nand_chip *nand =3D mtd_to_nand(mtd);
>         struct nand_ecc_ctrl *ecc =3D &nand->ecc;
> -       int offset =3D ((ecc->bytes + 4) * ecc->steps);
> +       int offset =3D ((ecc->bytes + USER_DATA_SZ) * ecc->steps);
>         int len =3D mtd->oobsize - offset;
>
>         if (len <=3D 0)
> @@ -966,7 +966,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info=
 *mtd,
>
>         for (i =3D 0; i < ecc->steps; i++) {
>                 int data_off =3D i * ecc->size;
> -               int oob_off =3D i * (ecc->bytes + 4);
> +               int oob_off =3D i * (ecc->bytes + USER_DATA_SZ);
>                 u8 *data =3D buf + data_off;
>                 u8 *oob =3D chip->oob_poi + oob_off;
>
> @@ -1004,7 +1004,7 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct mtd=
_info *mtd,
>         for (i =3D data_offs / ecc->size;
>              i < DIV_ROUND_UP(data_offs + readlen, ecc->size); i++) {
>                 int data_off =3D i * ecc->size;
> -               int oob_off =3D i * (ecc->bytes + 4);
> +               int oob_off =3D i * (ecc->bytes + USER_DATA_SZ);
>                 u8 *data =3D bufpoi + data_off;
>                 u8 *oob =3D chip->oob_poi + oob_off;
>
> @@ -1032,7 +1032,7 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_i=
nfo *mtd,
>
>         for (i =3D 0; i < ecc->steps; i++) {
>                 int data_off =3D i * ecc->size;
> -               int oob_off =3D i * (ecc->bytes + 4);
> +               int oob_off =3D i * (ecc->bytes + USER_DATA_SZ);
>                 const u8 *data =3D buf + data_off;
>                 const u8 *oob =3D chip->oob_poi + oob_off;
>
> @@ -1066,7 +1066,7 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct mt=
d_info *mtd,
>         for (i =3D data_offs / ecc->size;
>              i < DIV_ROUND_UP(data_offs + data_len, ecc->size); i++) {
>                 int data_off =3D i * ecc->size;
> -               int oob_off =3D i * (ecc->bytes + 4);
> +               int oob_off =3D i * (ecc->bytes + USER_DATA_SZ);
>                 const u8 *data =3D buf + data_off;
>                 const u8 *oob =3D chip->oob_poi + oob_off;
>
> @@ -1095,10 +1095,10 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(st=
ruct mtd_info *mtd,
>         sunxi_nfc_hw_ecc_enable(mtd);
>
>         for (i =3D 0; i < ecc->steps; i++) {
> -               int data_off =3D i * (ecc->size + ecc->bytes + 4);
> +               int data_off =3D i * (ecc->size + ecc->bytes + USER_DATA_=
SZ);
>                 int oob_off =3D data_off + ecc->size;
>                 u8 *data =3D buf + (i * ecc->size);
> -               u8 *oob =3D chip->oob_poi + (i * (ecc->bytes + 4));
> +               u8 *oob =3D chip->oob_poi + (i * (ecc->bytes + USER_DATA_=
SZ));
>
>                 ret =3D sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, =
oob,
>                                                   oob_off, &cur_off,
> @@ -1129,10 +1129,10 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(s=
truct mtd_info *mtd,
>         sunxi_nfc_hw_ecc_enable(mtd);
>
>         for (i =3D 0; i < ecc->steps; i++) {
> -               int data_off =3D i * (ecc->size + ecc->bytes + 4);
> +               int data_off =3D i * (ecc->size + ecc->bytes + USER_DATA_=
SZ);
>                 int oob_off =3D data_off + ecc->size;
>                 const u8 *data =3D buf + (i * ecc->size);
> -               const u8 *oob =3D chip->oob_poi + (i * (ecc->bytes + 4));
> +               const u8 *oob =3D chip->oob_poi + (i * (ecc->bytes + USER=
_DATA_SZ));
>
>                 ret =3D sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off,
>                                                    oob, oob_off, &cur_off=
,
> @@ -1390,7 +1390,7 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struc=
t mtd_info *mtd,
>         layout =3D &data->layout;
>         nsectors =3D mtd->writesize / ecc->size;
>
> -       if (mtd->oobsize < ((ecc->bytes + 4) * nsectors)) {
> +       if (mtd->oobsize < ((ecc->bytes + USER_DATA_SZ) * nsectors)) {
>                 ret =3D -EINVAL;
>                 goto err;
>         }
> @@ -1440,14 +1440,14 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd=
_info *mtd,
>                                 layout->oobfree[i - 1].offset +
>                                 layout->oobfree[i - 1].length +
>                                 ecc->bytes;
> -                       layout->oobfree[i].length =3D 4;
> +                       layout->oobfree[i].length =3D USER_DATA_SZ;
>                 } else {
>                         /*
>                          * The first 2 bytes are used for BB markers, hen=
ce we
> -                        * only have 2 bytes available in the first user =
data
> -                        * section.
> +                        * only have USER_DATA_SZ - 2 bytes available in =
the
> +                        * first user data section.
>                          */
> -                       layout->oobfree[i].length =3D 2;
> +                       layout->oobfree[i].length =3D USER_DATA_SZ - 2;
>                         layout->oobfree[i].offset =3D 2;
>                 }
>
> @@ -1457,13 +1457,13 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd=
_info *mtd,
>                                         layout->oobfree[i].length + j;
>         }
>
> -       if (mtd->oobsize > (ecc->bytes + 4) * nsectors) {
> +       if (mtd->oobsize > (ecc->bytes + USER_DATA_SZ) * nsectors) {
>                 layout->oobfree[nsectors].offset =3D
>                                 layout->oobfree[nsectors - 1].offset +
>                                 layout->oobfree[nsectors - 1].length +
>                                 ecc->bytes;
>                 layout->oobfree[nsectors].length =3D mtd->oobsize -
> -                               ((ecc->bytes + 4) * nsectors);
> +                               ((ecc->bytes + USER_DATA_SZ) * nsectors);
>         }
>
>         return 0;
> @@ -1481,7 +1481,7 @@ static int sunxi_nand_hw_syndrome_ecc_ctrl_init(str=
uct mtd_info *mtd,
>         if (ret)
>                 return ret;
>
> -       ecc->prepad =3D 4;
> +       ecc->prepad =3D USER_DATA_SZ;
>         ecc->read_page =3D sunxi_nfc_hw_syndrome_ecc_read_page;
>         ecc->write_page =3D sunxi_nfc_hw_syndrome_ecc_write_page;
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sun=
xi_nand.h
> index 6ee3ea14ee17..d7a8b3dd40c3 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.h
> +++ b/drivers/mtd/nand/raw/sunxi_nand.h
> @@ -181,6 +181,9 @@
>
>  #define NFC_MAX_CS             7
>
> +/* On A10, the user data length register is 4 bytes */
> +#define USER_DATA_SZ 4
> +
>  /*
>   * NAND Controller capabilities structure: stores NAND controller capabi=
lities
>   * for distinction between compatible strings.
> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw=
/sunxi_nand_spl.c
> index 67f7d22ed2c8..3a5271b49c36 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> @@ -269,6 +269,11 @@ static void sunxi_nfc_set_user_data_len(const struct=
 nfc_config *nfc,
>         writel_nfc(val, NFC_REG_USER_DATA_LEN(nfc, step));
>  }
>
> +/*
> + * Values in this table are obtained by doing:
> + * DIV_ROUND_UP(info->ecc_strength * 14, 8) + USER_DATA_SZ
> + * So it's the number of bytes needed for ECC + user data for one step.
> + */
>  #if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
>  static const int ecc_bytes[] =3D {
>         32, 46, 54, 60, 74, 82, 88, 96, 102, 110, 116, 124, 130, 138, 144
> @@ -338,7 +343,7 @@ static int nand_read_page(const struct nfc_config *co=
nf, u32 offs,
>                 nand_change_column(oob_off);
>
>                 sunxi_nfc_reset_user_data_len(conf);
> -               sunxi_nfc_set_user_data_len(conf, 4, 0);
> +               sunxi_nfc_set_user_data_len(conf, USER_DATA_SZ, 0);
>
>                 nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
>                 /* Get the ECC status */

Reviwed-By: Michael Trimarchi <michael@amarulasolutions.com>
