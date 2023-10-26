Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88708C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 13:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A7E687607;
	Thu, 26 Oct 2023 15:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hqQOglOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B96E875ED; Thu, 26 Oct 2023 15:23:33 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E11168760D
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 15:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-27d27026dc2so214425a91.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698326605; x=1698931405; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pq8Bol37tRSU/3t43WO3dJIyLBHSlKPAK6gViR32Pac=;
 b=hqQOglOD3lLrj0Lfx4uVNN1Psg1BYGgTUXy2UParT2R4LkTYa/50IavTppqpGH3voi
 6YDYEL3H8WDUUeEvxzZUkiTwv+4IZ4aL6f1+s9ScXdS8h5Wm0SAWIUYy9mmZMBLNmb8A
 TFM6L55kQtK+Hs+ga6zhfQBQyg1wectWzskYbtF0gM9qjyGwQLCzSWPBYhrbKyhP+lu9
 HMnItaPVCuLt1L4NxWnRMY37G3ULsP8LAFhXmMe+EDrKdaxVnANtsYTVXDlWoK6BuCbQ
 ZWk3RcbQzcr/ipIkvLVKKjQbRNh86i7vbfzgQBGVv3JA3KJP1Z2Li/P9H/zVugX58jLX
 fkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698326605; x=1698931405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pq8Bol37tRSU/3t43WO3dJIyLBHSlKPAK6gViR32Pac=;
 b=B9IiFP1tC3ZZEtRFxTnlSNT4d8bXMb5MZJNG6L9aP70f5pr87PMWMQ5Je2IQm86kUz
 z8J/b/zMG7PsmTomTzh+T3Z5PTr12WXegScL7ejduBfl0QfjE6MM0Pu2id+gIaUIBWN2
 RytplcZJGrA0OAJt7z5xJkYe8QdlNCZHJC3GVvhraZVNk4gxuixGKW10UF9dU7Bh6d5D
 PQHvzc+dGU+EMoN/z7Wh0Cem808S82+Qlunn9reV7gkaZT9LtUpUL+qVH/98lI4/r4l2
 nOGSf+omB3BDt1PgEnFYhbXHrgb+HzxGlZvdk6kcrmkyhOIjOWJcdRLVAxy4YosrIuDh
 PuOA==
X-Gm-Message-State: AOJu0YzdNzzZBGUNLJTXKWzePegH2IOG1JQz2ZBAvPTRtRF3/kOk9Eyu
 AMxYnFUGEhAOQl3fJMcni2OoAwbTvbqPtKFzWU4=
X-Google-Smtp-Source: AGHT+IGxJ2IGfmMmJl5BcS3gprq0BfilxVk/qaBFUBvg7XUjtZoa/LFsA0lrx/VsjKwqYubzTYfQxv1eDPhMt1QaClk=
X-Received: by 2002:a17:90b:3e8e:b0:27d:32d8:5f23 with SMTP id
 rj14-20020a17090b3e8e00b0027d32d85f23mr20029165pjb.2.1698326604915; Thu, 26
 Oct 2023 06:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231021123947.434-1-egyszeregy@freemail.hu>
In-Reply-To: <20231021123947.434-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Oct 2023 10:23:13 -0300
Message-ID: <CAOMZO5CftTZHkb022oGXzrrGX1cEne=PStTBw=FcTKnPv6DyeA@mail.gmail.com>
Subject: Re: [PATCH 1/1] [u-boot][master][PATCH v5] pico-imx7d: add baseboard
 SD card boot detect
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br
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

On Sat, Oct 21, 2023 at 9:40=E2=80=AFAM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Technexion PICO-IMX7 SoM is supporting USDHC3 (eMMC or micro SD on SoM)
> and USDHC1 (SD on carrier board) to use on any carrier board like
> PICO-NYMPH. This pacth is intend to take over codes from Technexion
> to support mmc autodetect boot for pico-imx7d to able to boot from
> selected USDHC1 or USDHC3 boot devices.
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> ---

Please always provide a changelog.

>  board/technexion/pico-imx7d/pico-imx7d.c | 59 ++++++++++++++-
>  board/technexion/pico-imx7d/spl.c        | 91 ++++++++++++++++++++++--
>  include/configs/pico-imx7d.h             |  4 +-
>  3 files changed, 145 insertions(+), 9 deletions(-)
>
> diff --git a/board/technexion/pico-imx7d/pico-imx7d.c b/board/technexion/=
pico-imx7d/pico-imx7d.c
> index 6e98b85b28..01a9520d32 100644
> --- a/board/technexion/pico-imx7d/pico-imx7d.c
> +++ b/board/technexion/pico-imx7d/pico-imx7d.c
> @@ -5,6 +5,7 @@
>
>  #include <init.h>
>  #include <net.h>
> +#include <command.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/crm_regs.h>
>  #include <asm/arch/imx-regs.h>
> @@ -13,6 +14,7 @@
>  #include <asm/global_data.h>
>  #include <asm/gpio.h>
>  #include <asm/mach-imx/iomux-v3.h>
> +#include <asm/mach-imx/boot_mode.h>
>  #include <asm/io.h>
>  #include <common.h>
>  #include <miiphy.h>
> @@ -106,7 +108,7 @@ int board_phy_config(struct phy_device *phydev)
>  {
>         unsigned short val;
>
> -       /* To enable AR8035 ouput a 125MHz clk from CLK_25M */
> +       /* To enable AR8035 output a 125MHz clk from CLK_25M */

This is an unrelated change.

>         phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x7);
>         phy_write(phydev, MDIO_DEVAD_NONE, 0xe, 0x8016);
>         phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x4007);
> @@ -129,6 +131,49 @@ int board_phy_config(struct phy_device *phydev)
>  }
>  #endif
>
> +#if CONFIG_IS_ENABLED(FSL_ESDHC_IMX)
> +int check_mmc_autodetect(void)
> +{
> +       char *autodetect_str =3D env_get("mmcautodetect");
> +
> +       if ((autodetect_str) &&
> +           (strcmp(autodetect_str, "yes") =3D=3D 0)) {
> +               return 1;
> +       }

No need for { to enclose a single line statement. Please remove it.


> +
> +       return 0;
> +}
> +
> +void board_late_mmc_init(void)
> +{
> +       int dev_no =3D 0;
> +       char cmd[32];
> +
> +       if (!check_mmc_autodetect())
> +               return;
> +
> +       switch (get_boot_device()) {
> +       case SD3_BOOT:
> +       case MMC3_BOOT:
> +               env_set("bootdev", "MMC3");
> +               dev_no =3D 2;
> +               break;
> +       case SD1_BOOT:
> +               env_set("bootdev", "SD1");
> +               dev_no =3D 0;
> +               break;

These dev_no assignments are not correct.

imx7d-pico-pi-u-boot.dtsi defines aliases for the eMMC:

    aliases {
        mmc0 =3D &usdhc3;

So to avoid errors, I had to apply the following change on top o your patch=
:

--- a/board/technexion/pico-imx7d/pico-imx7d.c
+++ b/board/technexion/pico-imx7d/pico-imx7d.c
@@ -156,11 +156,11 @@ void board_late_mmc_init(void)
        case SD3_BOOT:
        case MMC3_BOOT:
                env_set("bootdev", "MMC3");
-               dev_no =3D 2;
+               dev_no =3D 0;
                break;
        case SD1_BOOT:
                env_set("bootdev", "SD1");
-               dev_no =3D 0;
+               dev_no =3D 1;
                break;
        default:
                printf("Wrong boot device!");

> @@ -13,7 +13,7 @@
>  #define CFG_MXC_UART_BASE              UART5_IPS_BASE_ADDR
>
>  /* MMC Config */
> -#define CFG_SYS_FSL_ESDHC_ADDR 0
> +#define CFG_SYS_FSL_ESDHC_ADDR USDHC3_BASE_ADDR

Is this change needed?

>  #define CFG_DFU_ENV_SETTINGS \
>         "dfu_alt_info=3D" \
> @@ -79,9 +79,11 @@
>                 "name=3Drootfs,size=3D0,uuid=3D${uuid_gpt_rootfs}\0" \
>         "fastboot_partition_alias_system=3Drootfs\0" \
>         "setup_emmc=3Dmmc dev 0; gpt write mmc 0 $partitions; reset;\0" \
> +       "mmcautodetect=3Dyes\0" \
>         PICO_BOOT_ENV
>
>  #define BOOT_TARGET_DEVICES(func) \
> +       func(MMC, mmc, 2) \

This should be func(MMC, mmc, 1)

Please define aliases if needed.
