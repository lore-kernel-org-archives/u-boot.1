Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686BFCCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 06:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF3AD82A9E;
	Mon, 27 Oct 2025 07:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Be170ffj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5FE382C7F; Mon, 27 Oct 2025 07:33:14 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E44BF80422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b6cf07258e3so3108107a12.0
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 23:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1761546790; x=1762151590;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VergQKVaXpHrlusfozZqIlrye2RaOygmwoNN2HC/SdU=;
 b=Be170ffjCa9+KfXgiH3yvgcGlPwmlpZSSIAeOhzG/3lxzSWo2ymEwZyNpy2uaqmRMt
 33mA1pw1OYQ6Nnoo7lUdVoYVuxhbnoZbkBHzikXLnvCzb10ATZdGqSG0Jq3ZzC6Js522
 vCJsaEyVnitwg99pfJ7vJmygjL7lJySBLjMwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761546790; x=1762151590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VergQKVaXpHrlusfozZqIlrye2RaOygmwoNN2HC/SdU=;
 b=WzXVi00cha97O3SN+QiG2eWJ1Fqx/Har9B6xphoVB9rQtmKz9I/spvgalPG7biJIo/
 nCjMyiLkjKvY/GE4EB7vj4tA5JxeE9fzAoYiyFrcyIx+jTsUjZWoX8jhojl+Ls0p1Ttb
 NkPBelaF/Z3JwhilwBEMnSdkQLfh7WVBWeK9kreb1hCXiwJfN1cBY18lHkTEAn66KbNI
 yD+HcBEjtvaFkl10VpM+8hdp7hoSHJhO0dyKyJyLH5Ujvqmc7Ebf3vqLGykE2y97PCPv
 iwPw6MfZL17eMXF5B/lpWRvjyh09TdW1GQXsLPoRPQuKhcYEJZx9A/nICIG4Ahdctt5y
 Pn3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/IBQ/iS4dKexPkI9MVP5acyeV99Z8AIJeHWUChvgyj0izGZpUfgIIOc4gyH1KonzjqcYRnto=@lists.denx.de
X-Gm-Message-State: AOJu0YwwZmduP8zKAnQQspE9cSiO0aGuTsTyj39x+PDwZY7B+2LEwFqi
 pet8xyZjKMY+BPzWzZi3aC0hZMqsUz7F3W98J2MbODC3L5KgHADWT6OZpiQTjnFwEatpjA7mMPB
 gPvbcCEEfDPbdHMOgI9xidMA9MXEzw89E30TagLoqUA==
X-Gm-Gg: ASbGnctMG8wI3A/VJhnlpFT303FixjxnK/F+ylGB68pjDZ8ka5GEVW6OrjkZsnf0XZX
 l0iD0BTDM9B6yWfFnnaMJfI5GMd/qAtbAnrEPkXwpO72PUw4yiO9/BO//CEPnjAK6NrIT0KCK0Y
 7Hn2MeFvCFLK4v1yI7XbSMTyS0lj1MQuXT6OAuYrJc9zOw1pOe1RZTPSXTSRQqtbBw7FAQoyntj
 DzDxDw6azr7fouuZZ+gY5M7XcORFJMqhxeUdv2X6Sk8USaTziW09kXdaSm6ysby/semfuJ6EY2C
 SucloUAhuwlq9VdiqBL1lXuVi7U=
X-Google-Smtp-Source: AGHT+IEg3iqMul5F99pH2UBODImWqvJnDeRsIvdh3s/xayVkDwP8B5JexJ5xBMyQEgNKB0AJ6gExuw85+1ZB27TqEpI=
X-Received: by 2002:a17:903:11ce:b0:269:9adf:839 with SMTP id
 d9443c01a7336-290c9ca7e27mr430579505ad.19.1761546790131; Sun, 26 Oct 2025
 23:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251021080120.550081-1-richard.genoud@bootlin.com>
In-Reply-To: <20251021080120.550081-1-richard.genoud@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 27 Oct 2025 07:32:58 +0100
X-Gm-Features: AWmQ_bm6wPcFTXq3PZYbb5uKaiC7OxuhSjn4VvvNVJNWz9eeHYxgtZDDXAMdkvk
Message-ID: <CAOf5uwnK0TbJ2odTQExu909GFFPTtzL_-e6+ZOyjVdv8t+UepQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools: sunxi-spl-image-builder: support H6/H616 NAND
 boot
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, 
 Anand Gore <anand.gore@broadcom.com>, david regan <dregan@broadcom.com>, 
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>
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

Hi Richard

On Tue, Oct 21, 2025 at 10:01=E2=80=AFAM Richard Genoud
<richard.genoud@bootlin.com> wrote:
>
> The H6/H616 boot ROM doesn't expect a SPL scrambled the same way as
> older SoCs.
> It doesn't use a specific seeds table, it expects a maximized ECC
> (BCH-80), a specific BBM (FF000301) and doesn't work if empty pages are
> skipped (it needs its specific BBM, even in the padding).
>
> So, add a -h6 parameter to support H6/616 with:
> - more ECC strengths
> - specific BBM
> - default_scrambler_seeds[] with all values
> - no empty pages skip
>
> In Kconfig, select BCH-80 by default for SUNXI_SPL_ECC_STRENGTH to make
> BROM happy.
>
> And in scripts/Makefile.xpl, use --h6 parameter when building for a
> SUN50I_GEN_H6 SoC.
>
> Tested on Whatsminer H616 board, booting from NAND.
>
> Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/mtd/nand/raw/Kconfig    |  1 +
>  scripts/Makefile.xpl            |  1 +
>  tools/sunxi-spl-image-builder.c | 89 ++++++++++++++++++++++++++-------
>  3 files changed, 72 insertions(+), 19 deletions(-)
>
> Changes from v1:
> - move up "default 80 if SUN50I_GEN_H6" (sorry for the noise)
>
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 754b99bf3eb6..eb939ee85f88 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -483,6 +483,7 @@ if NAND_SUNXI
>
>  config NAND_SUNXI_SPL_ECC_STRENGTH
>         int "Allwinner NAND SPL ECC Strength"
> +       default 80 if SUN50I_GEN_H6
>         default 64
>
>  config NAND_SUNXI_SPL_ECC_SIZE
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index 52f014ad3324..aa4ee5cc1ce7 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -455,6 +455,7 @@ $(obj)/sunxi-spl.bin: $(obj)/$(SPL_BIN).bin FORCE
>
>  quiet_cmd_sunxi_spl_image_builder =3D SUNXI_SPL_IMAGE_BUILDER $@
>  cmd_sunxi_spl_image_builder =3D $(objtree)/tools/sunxi-spl-image-builder=
 \
> +                               $(if $(CONFIG_SUN50I_GEN_H6),--h6) \
>                                 -c $(CONFIG_NAND_SUNXI_SPL_ECC_STRENGTH)/=
$(CONFIG_NAND_SUNXI_SPL_ECC_SIZE) \
>                                 -p $(CONFIG_SYS_NAND_PAGE_SIZE) \
>                                 -o $(CONFIG_SYS_NAND_OOBSIZE) \
> diff --git a/tools/sunxi-spl-image-builder.c b/tools/sunxi-spl-image-buil=
der.c
> index a367f1177403..f9ba1c474be9 100644
> --- a/tools/sunxi-spl-image-builder.c
> +++ b/tools/sunxi-spl-image-builder.c
> @@ -27,6 +27,7 @@ struct image_info {
>         int eraseblock_size;
>         int scramble;
>         int boot0;
> +       int h6;

Was it better to call it soc and then enable this option for this core
and for the feature core that
will have the same?

Then you can move to switch default to handle the cases.

Michael

>         off_t offset;
>         const char *source;
>         const char *dest;
> @@ -84,18 +85,29 @@ static void scramble(const struct image_info *info,
>         uint16_t state;
>         int i;
>
> -       /* Boot0 is always scrambled no matter the command line option. *=
/
> -       if (info->boot0) {
> +       /*
> +        * Bail out earlier if the user didn't ask for scrambling.
> +        * But Boot0 is always scrambled no matter the command line optio=
n.
> +        */
> +       if (!info->boot0 && !info->scramble)
> +               return;
> +
> +       /*
> +        * On H6, the BROM scrambler seed is no different than the defaul=
t one
> +        */
> +       if (info->boot0 && !info->h6) {
>                 state =3D brom_scrambler_seeds[0];
>         } else {
> -               unsigned seedmod =3D info->eraseblock_size / info->page_s=
ize;
> +               unsigned int seedmod;
>
> -               /* Bail out earlier if the user didn't ask for scrambling=
. */
> -               if (!info->scramble)
> -                       return;
> -
> -               if (seedmod > ARRAY_SIZE(default_scrambler_seeds))
> +               if (info->h6) {
> +                       /* H6 boot0 uses all 128 seeds */
>                         seedmod =3D ARRAY_SIZE(default_scrambler_seeds);
> +               } else {
> +                       seedmod =3D info->eraseblock_size / info->page_si=
ze;
> +                       if (seedmod > ARRAY_SIZE(default_scrambler_seeds)=
)
> +                               seedmod =3D ARRAY_SIZE(default_scrambler_=
seeds);
> +               }
>
>                 state =3D default_scrambler_seeds[page % seedmod];
>         }
> @@ -137,14 +149,19 @@ static int write_page(const struct image_info *info=
, uint8_t *buffer,
>
>         fwrite(buffer, info->page_size + info->oob_size, 1, dst);
>
> -       for (i =3D 0; i < info->usable_page_size; i++) {
> -               if (buffer[i] !=3D  0xff)
> -                       break;
> -       }
> +       /*
> +        * H6 BROM doesn't support empty pages
> +        */
> +       if (!info->h6) {
> +               for (i =3D 0; i < info->usable_page_size; i++) {
> +                       if (buffer[i] !=3D  0xff)
> +                               break;
> +               }
>
> -       /* We leave empty pages at 0xff. */
> -       if (i =3D=3D info->usable_page_size)
> -               return 0;
> +               /* We leave empty pages at 0xff. */
> +               if (i =3D=3D info->usable_page_size)
> +                       return 0;
> +       }
>
>         /* Restore the source pointer to read it again. */
>         fseek(src, -cnt, SEEK_CUR);
> @@ -212,6 +229,14 @@ static int write_page(const struct image_info *info,=
 uint8_t *buffer,
>                 }
>
>                 memset(ecc, 0, eccbytes);
> +
> +               if (info->h6) {
> +                       /* BBM taken from vendor code: FF 00 03 01 */
> +                       buffer[info->ecc_step_size + 1] =3D 0;
> +                       buffer[info->ecc_step_size + 2] =3D 3; // NAND_VE=
RSION_0
> +                       buffer[info->ecc_step_size + 3] =3D 1; // NAND_VE=
RSION_1
> +               }
> +
>                 swap_bits(buffer, info->ecc_step_size + 4);
>                 encode_bch(bch, buffer, info->ecc_step_size + 4, ecc);
>                 swap_bits(buffer, info->ecc_step_size + 4);
> @@ -303,6 +328,7 @@ static void display_help(int status)
>                 "-e <size>        --eraseblock=3D<size>  Erase block size=
\n"
>                 "-b               --boot0              Build a boot0 imag=
e.\n"
>                 "-s               --scramble           Scramble data\n"
> +               "-6               --h6                 Build an image com=
patible with H6/H616 SoC\n"
>                 "-a <offset>      --address=3D<offset>   Where the image =
will be programmed.\n"
>                 "\n"
>                 "Notes:\n"
> @@ -313,6 +339,9 @@ static void display_help(int status)
>                 "  Valid ECC strengths: 16, 24, 28, 32, 40, 48, 56, 60 an=
d 64\n"
>                 "  Valid ECC step size: 512 and 1024\n"
>                 "\n"
> +               "On H6/H616, the only ECC step size supported is 1024, bu=
t more ECC\n"
> +               "strengths are supported: 44, 52, 68, 72, 76, 80\n"
> +               "\n"
>                 "If you are building a boot0 image, you'll have specify e=
xtra options.\n"
>                 "These options should be chosen based on the layouts desc=
ribed here:\n"
>                 "  http://linux-sunxi.org/NAND#More_information_on_BROM_N=
AND\n"
> @@ -342,7 +371,12 @@ static void display_help(int status)
>
>  static int check_image_info(struct image_info *info)
>  {
> -       static int valid_ecc_strengths[] =3D { 16, 24, 28, 32, 40, 48, 56=
, 60, 64 };
> +       static int ecc_strengths_a10[] =3D { 16, 24, 28, 32, 40, 48, 56, =
60, 64 };
> +       static int ecc_strengths_h6[] =3D {
> +               16, 24, 28, 32, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 8=
0
> +       };
> +       int *valid_ecc_strengths;
> +       size_t nstrengths;
>         int eccbytes, eccsteps;
>         unsigned i;
>
> @@ -367,12 +401,25 @@ static int check_image_info(struct image_info *info=
)
>                 return -EINVAL;
>         }
>
> -       for (i =3D 0; i < ARRAY_SIZE(valid_ecc_strengths); i++) {
> +       if (info->h6) {
> +               if (info->ecc_step_size !=3D 1024) {
> +                       fprintf(stderr,
> +                               "H6 SoCs supports only 1024 bytes ECC ste=
p\n");
> +                       return -EINVAL;
> +               }
> +               valid_ecc_strengths =3D ecc_strengths_h6;
> +               nstrengths =3D ARRAY_SIZE(ecc_strengths_h6);
> +       } else {
> +               valid_ecc_strengths =3D ecc_strengths_a10;
> +               nstrengths =3D ARRAY_SIZE(ecc_strengths_a10);
> +       }
> +
> +       for (i =3D 0; i < nstrengths; i++) {
>                 if (valid_ecc_strengths[i] =3D=3D info->ecc_strength)
>                         break;
>         }
>
> -       if (i =3D=3D ARRAY_SIZE(valid_ecc_strengths)) {
> +       if (i =3D=3D nstrengths) {
>                 fprintf(stderr, "Invalid ECC strength argument: %d\n",
>                         info->ecc_strength);
>                 return -EINVAL;
> @@ -416,10 +463,11 @@ int main(int argc, char **argv)
>                         {"boot0", no_argument, 0, 'b'},
>                         {"scramble", no_argument, 0, 's'},
>                         {"address", required_argument, 0, 'a'},
> +                       {"h6", no_argument, 0, '6'},
>                         {0, 0, 0, 0},
>                 };
>
> -               int c =3D getopt_long(argc, argv, "c:p:o:u:e:ba:sh",
> +               int c =3D getopt_long(argc, argv, "c:p:o:u:e:ba:sh6",
>                                 long_options, &option_index);
>                 if (c =3D=3D EOF)
>                         break;
> @@ -454,6 +502,9 @@ int main(int argc, char **argv)
>                 case 'a':
>                         info.offset =3D strtoull(optarg, NULL, 0);
>                         break;
> +               case '6':
> +                       info.h6 =3D 1;
> +                       break;
>                 case '?':
>                         display_help(-1);
>                         break;
>
> base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
> prerequisite-patch-id: 364de1b9fd9b3226884355a639c58e6d12f6f03b
> --
> 2.47.3
>


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
