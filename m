Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAC7CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB37848D1;
	Tue, 26 May 2026 15:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jfsH5d4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107F9848CF; Tue, 26 May 2026 15:36:33 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F3384873
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bd85ebb368fso1560240266b.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:36:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779802590; cv=none;
 d=google.com; s=arc-20240605;
 b=HclavbTrk9XBQ8na9t2hKlEYA+de1bD8lCiDbTvdY94rktubd3LEgdMa6mnjMvz10t
 bFzbGbLW/0ce3i/uq9DizhQJq45cVv6CUXB46KUvktrH2vaidb3IxzpgIntB8YxLm2Qc
 juYjRyQpQjgw9U6hkzkNH+hizxe2U6Z0CClY0gHCaJUJQZyWLUnh4xySxEtpO/9eV8cE
 j2SgGMAIzlZ74rYBKgmNqBFGKmRu3EXtJCiYJc5jVqqxDofJwkkkH7NCns9VGLohN88s
 489RX/k6RBoeKQHfD/5XntrsPKftF1utJjJROrJDxRyxtTAV6eMellufF9TPZNmY0GIa
 6Zlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Zg6dBX55jMZZc33prYS3USoE/KuxWsArIg4l141ClK4=;
 fh=Gry9tBDW6ujBdDGv28T8dCJmxXInL+Bez8p9bl8nXTk=;
 b=KEra57PpFTujHofBfWA15UQec3n3J/oWfloz+1XS/2g8juf0kVZnj9fssIPmwrBkqI
 h8KyjB/gvtdYzHhLZg59IjoqccSGFAJp6KQbf38MSy9aTT030YyAGD1ixs7AW/Rfr4/y
 Pf3y/DA+o/hSyjbZe2/IeGNmUujipdymncIozf/hA15x6yY2hMrewO1f0rsiTXSw/Twx
 oBnLu8KNgf1PyCPJFszqJRsY+d1hbM0YShoPXjP0kM/n+DvS5ovqI9Uqut6WIFRM/24w
 0eoQ/wzkIJAoSq0AxhAqrNdledvcoB9CO8gjOE4EcVyAvtriQP3sXpYFr23/hgLAXFed
 tfIw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779802590; x=1780407390; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zg6dBX55jMZZc33prYS3USoE/KuxWsArIg4l141ClK4=;
 b=jfsH5d4a2bPrEwRAyHPTo+dKM9VqwkpO/STy8BfD+UIlCNxRAHZBcebvlmUty/yAU/
 UtqVvu95LRVEB4YfcXhvwygi9cjt9kQbgY3LjklIf5r9yHRGlpP+awJYa5Xpw/TJmWhx
 kgAshgpsEQDJM24A+Q0Ih7vfokdOQuGT7pFMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779802590; x=1780407390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zg6dBX55jMZZc33prYS3USoE/KuxWsArIg4l141ClK4=;
 b=iKAY/GOac4DYGl/HbAIAEH40e5B88aiNdGY1KKEYxA90cgO9KFNh6ekdL5OKLnIZNO
 c8DszfsFMfWAsJOG3GT6DS3kSssXfdP1F6RIxqJnc7Lsy9/+KucAE2etfSRkJbXTcet1
 bSuxChF8HnSv/hqCfnSUk2sYNK6KmuCQxYdDW1xgc5hZiefOkI/UCHesaFYNKVmuLgEE
 bib8hrOcn3ehgvMSgt36dJpoyx7FAmJRm8xjvSe1g/e1l/mW0nvbZMPaTYyX0PPCBulY
 kfbQ+efpmp4GD/eJhtiejlYzonj5zfANfyG1Q3+bN2eo7i6rPN9dE3PvPg1KFKyTDC0v
 EXaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9+1isfIxCwpQ2Bln+kq0+8jcXq52PnQIg1MQYFk9eSci+7MZQlsgQkyfOy6wS6BgkMvn/Z6c=@lists.denx.de
X-Gm-Message-State: AOJu0YxwX4SZToo/sl3sX0xTFEPJfRLCMIN3bIuCeIUChae3oqKn/Muh
 veGEWiLKR/2h7tiHrwkM3V8JeFrYpK1tcHB2+zU3X9HAgL/Uzyo/Wko9NqJj6dYalAEh+MI5tfq
 o9rD5SQJsv5LaXBmC/X9RtCvgyvEeXmnVvytmyzKR
X-Gm-Gg: Acq92OH7OH7n31qVwDCm8ujeoe4YFmiFedXGeEvgDzdFOBqBgBtSUw7fZqRm158s4Ir
 8/jENEouz8+5aNTOblanJT6TBa3P/2pzIkqxGrg6lRbUReHik34uaoa3qIWJ6+xqQNn7UEe6X0q
 nVJaemZ9K/lbiQOHnmr9cwu1l4GO4Aa4GQS39cEkVrwGhg34sVyjBCpqt86/7i2zHP++Yeox826
 BQq10WHnK76gxRGe19jhZrkCskFJJfPYCbG4TZD+xefT7p4FMmbOcGre4LIOEU5Et7bfjhheq+G
 FqEuSZq/Y3T/pwm+Hbw=
X-Received: by 2002:a17:906:4fce:b0:bd4:e62e:d399 with SMTP id
 a640c23a62f3a-bdd25ceb7d0mr1166369466b.26.1779802590213; Tue, 26 May 2026
 06:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
 <20260520-b4-k1-spl-pinctrl-spinor-v2-6-8d25db98ac8e@riscstar.com>
In-Reply-To: <20260520-b4-k1-spl-pinctrl-spinor-v2-6-8d25db98ac8e@riscstar.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 08:36:18 -0500
X-Gm-Features: AVHnY4IipUqFhnYiuZhy-joioMqd117s9rwjhD-T3xWPjqrDHE4bINQHIsvdv38
Message-ID: <CAFLszThatbG9gMjpXLNmjy1jyuTS8X+_uXKGzacRsvOppv1USQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] spacemit: k1: Add multiple device tree support
To: Guodong Xu <guodong@riscstar.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de, 
 u-boot-spacemit@groups.io, Vignesh R <vigneshr@ti.com>,
 Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>, 
 Anis Chali <chalianis1@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>, Heiko Schocher <hs@nabladev.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>, 
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Guodong,

On Tue, 19 May 2026 at 16:49, Guodong Xu <guodong@riscstar.com> wrote:
>
> Enable multiple DTB support in the FIT image for the Spacemit K1 SoC,
> allowing a single U-Boot binary to support different board variants.
>
> The SPL reads the board type from EEPROM and selects the corresponding
> device tree at runtime via board_fit_config_name_match(), ensuring the
> correct hardware description is passed to U-Boot proper.
>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>
> ---
> v2:
> - Reworked.  Drop the v1 approach (new local k1-muse-pi-pro.dts,
>   enlarge SYS_MALLOC_F_LEN, MMODE switch).
> - Use binman --fit-multi-config so u-boot.itb packs multiple board
>   DTs from the upstream tree.
> ---
>  board/spacemit/k1/spl.c       | 42 ++++++++++++++++++++++++++++++++++--------
>  configs/spacemit_k1_defconfig |  2 ++
>  2 files changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> index da4169fbc8c..d749e21a2d5 100644
> --- a/board/spacemit/k1/spl.c
> +++ b/board/spacemit/k1/spl.c
> @@ -13,6 +13,7 @@
>  #include <dm/device.h>
>  #include <dm/uclass.h>
>  #include <i2c.h>
> +#include <linux/ctype.h>
>  #include <linux/delay.h>
>  #include <log.h>
>  #include <power/regulator.h>
> @@ -55,6 +56,8 @@ struct ddr_cfg {
>  binman_sym_declare(ulong, ddr_fw, image_pos);
>  binman_sym_declare(ulong, ddr_fw, size);
>
> +char product_name[I2C_BUF_SIZE] = "k1";
> +
>  static void i2c_early_init(void)
>  {
>         struct udevice *bus;
> @@ -322,14 +325,8 @@ void nor_early_init(void)
>         udelay(10);
>  }
>
> -void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
> -{
> -       return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
> -}
> -
>  void board_init_f(ulong dummy)
>  {
> -       u8 i2c_buf[I2C_BUF_SIZE] = { 0 };
>         int ret;
>
>         ret = spl_early_init();
> @@ -344,11 +341,11 @@ void board_init_f(ulong dummy)
>         preloader_console_init();
>
>         i2c_early_init();
> -       ret = read_product_name(i2c_buf, I2C_BUF_SIZE);
> +       ret = read_product_name(product_name, I2C_BUF_SIZE);
>         if (ret)
>                 log_info("Fail to detect board:%d\n", ret);
>         else
> -               log_info("Get board name:%s\n", (char *)i2c_buf);
> +               log_info("Get board name:%s\n", product_name);
>         pmic_init();

This is quite hacky. Firstly you should be able to delay selecting the
DT until board_init_r() - i.e. once SPL is running fully. Why is it
needed so early?

Then, you should be able to use a syscon driver to obtain the
information, using driver model. Do you have lots of size constraints
which prevent driver model in SPL?

>
>         ddr_early_init();
> @@ -363,3 +360,32 @@ u32 spl_boot_device(void)
>  void spl_board_init(void)
>  {
>  }
> +
> +int board_fit_config_name_match(const char *name)
> +{
> +       char fdt_name[I2C_BUF_SIZE];
> +       int i;
> +
> +       memset(fdt_name, 0, I2C_BUF_SIZE);
> +       if (!strncmp(product_name, "k1-x_", 5)) {
> +               snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
> +                        &product_name[5]);
> +       }
> +       if (fdt_name[0] == '\0') {

if (!*fdt_name) {

> +               /* set default board name */
> +               sprintf(fdt_name, "k1-musepi-pro");
> +       }
> +       for (i = 0; i < I2C_BUF_SIZE; i++) {
> +               if (fdt_name[i] == '\0')

same

how about adding a helper function in lib/ to lower-case and return a string?

> +                       break;
> +               fdt_name[i] = tolower(fdt_name[i]);
> +       }
> +       if (!strcmp(name, fdt_name))
> +               return 0;

blank line before final return

> +       return -ENOENT;
> +}
> +
> +void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
> +{
> +       return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
> +}
> diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
> index 64c724c62a5..465788cc2e5 100644
> --- a/configs/spacemit_k1_defconfig
> +++ b/configs/spacemit_k1_defconfig
> @@ -5,6 +5,7 @@ CONFIG_NR_DRAM_BANKS=2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
>  CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-musepi-pro"
> +CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"
>  CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
>  CONFIG_SPL_STACK=0xc083fb00
>  CONFIG_SPL_TEXT_BASE=0xc0801000
> @@ -27,6 +28,7 @@ CONFIG_SPL_RISCV_MMODE=y
>  # CONFIG_SPL_SMP is not set
>  CONFIG_STACK_SIZE=0x100000
>  CONFIG_FIT=y
> +CONFIG_MULTI_DTB_FIT=y
>  CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x08000000
>  CONFIG_SUPPORT_RAW_INITRD=y
>
> --
> 2.43.0
>

Regards,
Simon
