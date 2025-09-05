Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2DACA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 22:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA22883935;
	Sat,  6 Sep 2025 00:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="b2ijZZir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7DF883956; Sat,  6 Sep 2025 00:27:20 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF3D83906
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 00:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-24b2de2e427so19717925ad.2
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1757111236; x=1757716036;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRn4kGPOPyPmaCKc7R6PfqpzesWC9kbFzWayuHGlRVI=;
 b=b2ijZZirrZ6i+uU7Nk1pYA9YiCWT80ajt5PBYTgYZEloBHIu0r1ULby8C2e7wxm4qG
 0Et03vDMa5Uqc2hVQK2exuZGdjLo39AX3tc8e9ZccB/bn3O8CS/JIFvIUCk9McDbpLoU
 QPLiy/Sv5hZ+yVTFvkHv4sVML0JPQ8G8BWGA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757111236; x=1757716036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRn4kGPOPyPmaCKc7R6PfqpzesWC9kbFzWayuHGlRVI=;
 b=DwjghE5eEsoMssVVf3x4lEFSFlquZ6ZbgV8AomSx270//iZYPxs+IGe2LIeM/Dc9lh
 PWH8LQP+sWXGxj349YPCbBeBgstSAy1eZxG89twm1IMqVPLnhh1YlJNOt24Knm36UKPO
 n5YQdMVvv4cugMU7HiVqQWbZLexyRqpPjGeRpN3pke0rbB1P3vKfOOl/n9H9kb8GjIO1
 i2D5E4gd2ULPj5ZwCB7s+BQuCw84IDBO1QYJyiTZekgUsEdtGv0YEsrQbCV6FBk9NQEU
 suigwuytjBOZFXssDUgO3wEq7v7YjkZwh5sFe9X1dwO0rIwz6j30VAFbMU7Sn5E4gR//
 gKmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ8uz0MgyxorTO5kvG9mA+cKK624AdEr+FJguvvubVk/Cv3CLsnogNXXbKGomMZoSYBMAezic=@lists.denx.de
X-Gm-Message-State: AOJu0YzEePJtH29qg5yIIJear5Qy+l4FTOPq5puoeA8T/OrFVFNBy6Lw
 uckaiS2/S0jmtflTTiJzsLPaI5AJKeEO/nCh7DqBmG2FKKJaTE5/T1tfsbX/iNPteI/M1bT4jvD
 eaAahbq0u8p710WXfPA5CC2lIfQKzgg4b+Uq295zpeg==
X-Gm-Gg: ASbGncvUIZDQnxpdQH7SaHkQsV71egtOmoU0bL/jWczf52eLDgRj+OB8GPS00Z+SliI
 PLQsJ3TavL1vNcvuLmTrC5yhKAO2Zndv0JUDSaWMh824p6bOu3uWfj9AzQEMsmsz5PYyN/GWRiU
 WWChI9i94bcTJlvzoSSTEt7P1/N40qLum9X6dgFROJEj/sTtoc7Wh3SADA7Z0r/10w6jvhaAREE
 FYyKTc=
X-Google-Smtp-Source: AGHT+IGF9c0INFX9+u2lu1U8TmxTMjvUS+0IO1Iy6PvHZ1RLeCdVHeD4EBrD5ddxqnCyZR8647gf3GPq/gUd6LbVHSE=
X-Received: by 2002:a17:903:2c8:b0:24b:bbf2:47a6 with SMTP id
 d9443c01a7336-2516dfcc279mr3198795ad.16.1757111236533; Fri, 05 Sep 2025
 15:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250904145023.659922-1-mikhail.kshevetskiy@iopsys.eu>
 <20250904145023.659922-4-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20250904145023.659922-4-mikhail.kshevetskiy@iopsys.eu>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 6 Sep 2025 00:27:04 +0200
X-Gm-Features: Ac12FXzVtjCMBN3xd5CKM5ew45SmceKpntIuh1BkCO2dMLNO4ra99TfRvS0cX7k
Message-ID: <CAOf5uw=sH+QViWc1cT9ed68bHe_bQUPso0nhupm7QJSh05Agzg@mail.gmail.com>
Subject: Re: [PATCH 3/3] cmd: mtd: add nand_read_test command support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de, 
 Andreas Gnau <andreas.gnau@iopsys.eu>
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

On Thu, Sep 4, 2025 at 4:50=E2=80=AFPM Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This patch implements read-only test of nand flash devices.
>
> Test reads blocks of NAND flash in normal and raw modes and compares
> results. The following statuses can be returned for a block:
>  * non-ecc reading failed,
>  * ecc reading failed,
>  * block is bad,
>  * bitflips is above maximum,
>  * actual number of biflips above reported one,
>  * bitflips reached it maximum value,
>  * block is ok.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  cmd/Kconfig |  16 +++++
>  cmd/mtd.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 213 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index cd1a664f34f..21d6db57628 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1533,6 +1533,22 @@ config CMD_MTD_NAND_WRITE_TEST
>
>           WARNING: This test will destroy any data on blocks being tested=
.
>
> +config CMD_MTD_NAND_READ_TEST
> +       bool "mtd nand_read_test"
> +       depends on CMD_MTD
> +       help
> +         MTD nand_read_test command support.
> +
> +         Reads blocks of NAND flash in normal and raw modes and compares=
 results.
> +         The following statuses can be returned for a block:
> +           * non-ecc reading failed,
> +           * ecc reading failed,
> +           * block is bad,
> +           * bitflips is above maximum,
> +           * actual number of biflips above reported one,
> +           * bitflips reached it maximum value,
> +           * block is ok.
> +
>  config CMD_MUX
>         bool "mux"
>         depends on MULTIPLEXER
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index 4d69c7b4915..cee3a7e43ef 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -951,6 +951,195 @@ out_put_mtd:
>  }
>  #endif
>
> +#ifdef CONFIG_CMD_MTD_NAND_READ_TEST
> +enum nand_read_status {
> +       NAND_READ_STATUS_UNKNOWN =3D 0,
> +       NAND_READ_STATUS_NONECC_READ_FAIL,
> +       NAND_READ_STATUS_ECC_READ_FAIL,
> +       NAND_READ_STATUS_BAD_BLOCK,
> +       NAND_READ_STATUS_BITFLIP_ABOVE_MAX,
> +       NAND_READ_STATUS_BITFLIP_MISMATCH,
> +       NAND_READ_STATUS_BITFLIP_MAX,
> +       NAND_READ_STATUS_OK,
> +};
> +
> +static enum nand_read_status nand_read_block_check(struct mtd_info *mtd,
> +                                                  loff_t off, size_t blo=
cksize)
> +{
> +       struct mtd_oob_ops      ops =3D {};
> +       u_char                  *buf;
> +       int                     i, d, ret, len, pos, cnt, max;
> +
> +       if (blocksize % mtd->writesize !=3D 0) {
> +               printf("\r  block at 0x%llx: bad block size\n", off);
> +               return NAND_READ_STATUS_UNKNOWN;
> +       }
> +
> +       buf =3D malloc_cache_aligned(2 * blocksize);
> +       if (buf =3D=3D NULL) {
> +               printf("\r  block at 0x%llx: can't allocate memory\n", of=
f);
> +               return NAND_READ_STATUS_UNKNOWN;
> +       }
> +

I think that you can allocate those and check outside the function
only one time. Then you
can use standard return ENOMEM.

> +       ops.mode =3D MTD_OPS_RAW;
> +       ops.len =3D blocksize;
> +       ops.datbuf =3D buf;
> +       ops.ooblen =3D 0;
> +       ops.oobbuf =3D NULL;
> +

You don't need to set to 0 and null and if you drop the allocation and
the check then
you can initialize in the struct definition.

> +       if (mtd->_read_oob)
> +               ret =3D mtd->_read_oob(mtd, off, &ops);
> +       else
> +               ret =3D mtd->_read(mtd, off, ops.len, &ops.retlen, ops.da=
tbuf);
> +
> +       if (ret !=3D 0) {
> +               free(buf);
> +               printf("\r  block at 0x%llx: non-ecc reading error %d\n",
> +                      off, ret);
> +               return NAND_READ_STATUS_NONECC_READ_FAIL;
> +       }
> +
> +       ops.mode =3D MTD_OPS_AUTO_OOB;
> +       ops.datbuf =3D buf + blocksize;
> +
> +       if (mtd->_read_oob)
> +               ret =3D mtd->_read_oob(mtd, off, &ops);
> +       else
> +               ret =3D mtd->_read(mtd, off, ops.len, &ops.retlen, ops.da=
tbuf);
> +
> +       if (ret =3D=3D -EBADMSG) {
> +               free(buf);
> +               printf("\r  block at 0x%llx: bad block\n", off);
> +               return NAND_READ_STATUS_BAD_BLOCK;
> +       }
> +
> +       if (ret < 0) {
> +               free(buf);
> +               printf("\r  block at 0x%llx: ecc reading error %d\n", off=
, ret);
> +               return NAND_READ_STATUS_ECC_READ_FAIL;
> +       }
> +
> +       if (mtd->ecc_strength =3D=3D 0) {
> +               free(buf);
> +               return NAND_READ_STATUS_OK;
> +       }
> +
> +       if (ret > mtd->ecc_strength) {
> +               free(buf);
> +               printf("\r  block at 0x%llx: returned bit-flips value %d =
"
> +                      "is above maximum value %d\n",
> +                      off, ret, mtd->ecc_strength);
> +               return NAND_READ_STATUS_BITFLIP_ABOVE_MAX;
> +       }
> +
> +       max =3D 0;
> +       pos =3D 0;
> +       len =3D blocksize;
> +       while (len > 0) {
> +               cnt =3D 0;
> +               for (i =3D 0; i < mtd->ecc_step_size; i++) {
> +                       d =3D buf[pos + i] ^ buf[blocksize + pos + i];
> +                       if (d =3D=3D 0)
> +                               continue;
> +
> +                       while (d > 0) {
> +                               d &=3D (d - 1);
> +                               cnt++;
> +                       }
> +               }
> +               if (cnt > max)
> +                       max =3D cnt;
> +
> +               len -=3D mtd->ecc_step_size;
> +               pos +=3D mtd->ecc_step_size;
> +       }
> +
> +       free(buf);
> +
> +       if (max > ret) {
> +               printf("\r  block at 0x%llx: bitflip mismatch, "
> +                      "read %d but actual %d\n", off, ret, max);
> +               return NAND_READ_STATUS_BITFLIP_MISMATCH;
> +       }
> +
> +       if (ret =3D=3D mtd->ecc_strength) {
> +               printf("\r  block at 0x%llx: max bitflip reached, "
> +                      "block is unreliable\n", off);
> +               return NAND_READ_STATUS_BITFLIP_MAX;
> +       }
> +
> +       return NAND_READ_STATUS_OK;
> +}
> +
> +static int do_mtd_nand_read_test(struct cmd_tbl *cmdtp, int flag, int ar=
gc,
> +                                char *const argv[])
> +{
> +       struct mtd_info         *mtd;
> +       u64                     off, blocks;
> +       int                     stat[NAND_READ_STATUS_OK + 1];
> +       enum nand_read_status   ret;
> +
> +       if (argc < 2)
> +               return CMD_RET_USAGE;
> +
> +       mtd =3D get_mtd_by_name(argv[1]);
> +       if (IS_ERR_OR_NULL(mtd))
> +               return CMD_RET_FAILURE;
> +
> +       if (!mtd_can_have_bb(mtd)) {
> +               printf("Only NAND-based devices can be checked\n");
> +               goto out_put_mtd;
> +       }
> +
> +       blocks =3D mtd->size;
> +       do_div(blocks, mtd->erasesize);
> +
> +       printf("ECC strength:     %d\n",   mtd->ecc_strength);
> +       printf("ECC step size:    %d\n",   mtd->ecc_step_size);
> +       printf("Erase block size: 0x%x\n", mtd->erasesize);
> +       printf("Total blocks:     %lld\n", blocks);
> +
> +       printf("\nworking...\n");
> +       memset(stat, 0, sizeof(stat));
> +       for (off =3D 0; off < mtd->size; off +=3D mtd->erasesize) {
> +               ret =3D nand_read_block_check(mtd, off, mtd->erasesize);
> +               stat[ret]++;
> +
> +               switch (ret) {
> +               case NAND_READ_STATUS_BAD_BLOCK:
> +               case NAND_READ_STATUS_BITFLIP_MAX:
> +                       if (!mtd_block_isbad(mtd, off))
> +                               printf("\r  block at 0x%llx: should be ma=
rked "
> +                                      "as BAD\n", off);
> +                       break;
> +
> +               case NAND_READ_STATUS_OK:
> +                       if (mtd_block_isbad(mtd, off))
> +                               printf("\r  block at 0x%llx: marked as BA=
D, but "
> +                                      "probably is GOOD\n", off);
> +                       break;
> +
> +               default:
> +                       break;
> +               }
> +       }
> +
> +out_put_mtd:
> +       put_mtd_device(mtd);
> +       printf("\n");
> +       printf("results:\n");
> +       printf("  Good blocks:            %d\n", stat[NAND_READ_STATUS_OK=
]);
> +       printf("  Physically bad blocks:  %d\n", stat[NAND_READ_STATUS_BA=
D_BLOCK]);
> +       printf("  Unreliable blocks:      %d\n", stat[NAND_READ_STATUS_BI=
TFLIP_MAX]);
> +       printf("  Non checked blocks:     %d\n", stat[NAND_READ_STATUS_UN=
KNOWN]);
> +       printf("  Failed to check blocks: %d\n", stat[NAND_READ_STATUS_NO=
NECC_READ_FAIL] +
> +                                                stat[NAND_READ_STATUS_EC=
C_READ_FAIL]);
> +       printf("  Suspictious blocks:     %d\n", stat[NAND_READ_STATUS_BI=
TFLIP_ABOVE_MAX] +
> +                                                stat[NAND_READ_STATUS_BI=
TFLIP_MISMATCH]);
> +       return CMD_RET_SUCCESS;
> +}
> +#endif
> +
>  static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
>                       char *const argv[])
>  {
> @@ -1039,6 +1228,9 @@ U_BOOT_LONGHELP(mtd,
>  #endif
>  #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
>         "mtd nand_write_test                   <name>        [<off> [<siz=
e>]]\n"
> +#endif
> +#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
> +       "mtd nand_read_test                    <name>\n"
>  #endif
>         "\n"
>         "With:\n"
> @@ -1081,6 +1273,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help=
_text,
>                 U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
>                                              do_nand_write_test,
>                                              mtd_name_complete),
> +#endif
> +#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
> +               U_BOOT_SUBCMD_MKENT_COMPLETE(nand_read_test, 2, 0,
> +                                            do_mtd_nand_read_test,
> +                                            mtd_name_complete),
>  #endif
>                 U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
>                                              mtd_name_complete));
> --
> 2.50.1
>

Otherwise:

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
