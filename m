Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297CCC35FE7
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 05:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FA5688D9C;
	Sun, 15 Sep 2024 07:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HPPjH6F5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5835188C4A; Sat, 14 Sep 2024 22:18:18 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD72C88D40
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 22:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6dc7879ae5aso238777b3.1
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726345094; x=1726949894; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nH4CHBELEuhgcjMMy9F2LLnAcEVdxRLerqzyy//z9+s=;
 b=HPPjH6F57H50/uBRm7r5SxiBDMRbbXalJBWy+3J5HQPnRr0dU5DUU965aX6SroTMuJ
 h8vD0zwA4suobC2IcqJ6D5QYuxk4UI2/GWAieaGPO2kE07a8sj/5zxPOFDRA7+abuTzR
 THNp2ghRNf0qeeEmIpQrrsi5xXomBxxjM0PSmtkPub5S0aY85voq6k0hJEYG5U57zIFU
 snrcNFtkaO7aW26w7Aku7vBVWVDthnHmSG0375c/ZN3CnGZPN7bV2115T/YHooGNn6qZ
 /lAMqJw4n8Cl87RIlnGal5+dTTFylcnc0GlhVBoGFFcqJqMFsTdLhqu7itMFJLQwT+Hi
 uYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726345094; x=1726949894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nH4CHBELEuhgcjMMy9F2LLnAcEVdxRLerqzyy//z9+s=;
 b=jKnFVTDbPUjcdsjB4nfkGeKOuw5MdeoVZKQLVlDFlfpHb1mEg0IQXo/aolk+rgwDa7
 VozuQHSNZWIqyifSuVYhANdVrFaE/qgUJWfME21Gl4Vg5DTqtFAxYGw3vc3UAdoQ2e9+
 gw69pyAa47LxsWFgVzJcpdAVvWwu29v1ISvNHvQuBQC9xHncPY+O/1taVn+wtS4X+mwc
 1omdzs6leiRSdOuxzgqapN/WJFbSctrfAsgE9ic9GSfPWdgEPindsf4v1SeJdmgNNl1F
 pQHu7VEJaY9X3DzzMfbIJoIOgMpOREX9jpkZTZVGWVGe/Sc8Ag3+Ld46fUiWcKdncgzz
 W//Q==
X-Gm-Message-State: AOJu0Yw68Inf+YJmWrrUWpO+xgmLHSih79YJpy3qVpeySX3LFWCbMx3I
 jGfZX+pXaRrvP6n9Xexj8U61NgTpz+T6tGMRQoQOw655/JX2OacbnSQvZLud8ChXES5YraPkz5x
 9FWvPuiyPOHjnfOvtfAmsKbLZ+lQ=
X-Google-Smtp-Source: AGHT+IGMmklirZDHDuRDdv2d2teJZoawrXrswNOpc6WNxEB/khVr1yGT6fVPf7Npyptterw7mRx9AZ9Vigs5XWXEcf4=
X-Received: by 2002:a05:690c:398:b0:6c8:94e9:52a5 with SMTP id
 00721157ae682-6dbb6ad3cf4mr48401717b3.2.1726345094605; Sat, 14 Sep 2024
 13:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-4-l.rubusch@gmail.com>
 <20240912174507.GV4252@bill-the-cat>
In-Reply-To: <20240912174507.GV4252@bill-the-cat>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 14 Sep 2024 22:17:38 +0200
Message-ID: <CAFXKEHYQ+Z1nQ5-=ZLH1Nd+Yv43tv=S-5bzUzBLhYEQNe4X81w@mail.gmail.com>
Subject: Re: [PATCH 3/9] ARM: socfpga: add Enclustra AA1 SoM support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, marex@denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 15 Sep 2024 07:28:04 +0200
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

On Thu, Sep 12, 2024 at 7:45=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Sep 12, 2024 at 06:06:43AM +0000, Lothar Rubusch wrote:
>
> > Introduce initial support for the Enclustra SoMs:
> >
> > - Mercury AA1
> >
> > Cover general board files for SD/MMC and QSPI boot modes. Integrate the
> > boards to kconfig. All build variants will depend on Quartus handoff
> > files, thus they depend on the particular Quartus design. The approach =
is
> > covered in the according documentation part.
> >
> > Additionally add configuration for SD/MMC boot and QSPI bootmodes. Regi=
ster
> > additional targets in kconfig.
> >
> > Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> [snip]
> > diff --git a/board/enclustra/mercury_aa1/mercury_aa1.c b/board/enclustr=
a/mercury_aa1/mercury_aa1.c
> > new file mode 100644
> > index 0000000000..7de9b287d9
> > --- /dev/null
> > +++ b/board/enclustra/mercury_aa1/mercury_aa1.c
> > @@ -0,0 +1,185 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2024 Enclustra GmbH
> > + * <info@enclustra.com>
> > + */
> > +
> > +#include <command.h>
> > +#include <env.h>
> > +#include <init.h>
> > +#include <dm/uclass.h>
> > +#include <asm-generic/gpio.h>
> > +#include <asm/io.h>
> > +
> > +/* Pin muxing */
> > +#if !defined(CONFIG_SPL_BUILD)
> > +
> > +#define ALTERA_NONE 0
> > +#define ALTERA_MMC 1
> > +#define ALTERA_QSPI 2
> > +#define ALTERA_EMMC 3
> > +#define MMC_CLK_DIV 0x9
> > +#define QSPI_CLK_DIV 0x384
> > +#define ALTERA_PINMUX_OFFS 0xffd07200
> > +#define ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE 0xFFD04078
> > +
> > +static int altera_current_storage =3D ALTERA_NONE;
> > +
> > +#endif
> > +
> > +#if !defined(CONFIG_SPL_BUILD)
> > +
> > +static void set_mux_mmc(void)
> > +{
> > +     u32 pinmux_arr[] =3D {0x0c, 0x8,  // IO4 connected to SDMMC
> > +                     0x10, 0x8,      // IO5
> > +                     0x14, 0x8,      // IO6
> > +                     0x18, 0x8,      // IO7
> > +                     0x1c, 0x8,      // IO8
> > +                     0x20, 0x8,      // IO9
> > +                     0x24, 0xf,      // IO10 connected to GPIO
> > +                     0x28, 0xf,      // IO11
> > +                     0x2c, 0xf,      // IO12
> > +                     0x30, 0xf,      // IO13
> > +                     0x34, 0xf,      // IO14
> > +                     0x38, 0xf};     // IO15
> > +     u32 len, i, offset, value;
> > +
> > +     len =3D sizeof(pinmux_arr) / sizeof(u32);
> > +     for (i =3D 0; i < len; i +=3D 2) {
> > +             offset =3D pinmux_arr[i];
> > +             value =3D pinmux_arr[i + 1];
> > +             writel(value, ALTERA_PINMUX_OFFS + offset);
> > +     }
> > +}
> > +
> > +static void set_mux_emmc(void)
> > +{
> > +     u32 pinmux_arr[] =3D {0x0c, 0x8,  // IO4
> > +             0x10, 0x8,      // IO5
> > +             0x14, 0x8,      // IO6
> > +             0x18, 0x8,      // IO7
> > +             0x1c, 0x8,      // IO8
> > +             0x20, 0x8,      // IO9
> > +             0x24, 0xf,      // IO10
> > +             0x28, 0xf,      // IO11
> > +             0x2c, 0x8,      // IO12
> > +             0x30, 0x8,      // IO13
> > +             0x34, 0x8,      // IO14
> > +             0x38, 0x8};     // IO15
> > +     u32 len, i, offset, value;
> > +
> > +     len =3D sizeof(pinmux_arr) / sizeof(u32);
> > +     for (i =3D 0; i < len; i +=3D 2) {
> > +             offset =3D pinmux_arr[i];
> > +             value =3D pinmux_arr[i + 1];
> > +             writel(value, ALTERA_PINMUX_OFFS + offset);
> > +     }
> > +}
> > +
> > +static void set_mux_qspi(void)
> > +{
> > +     u32 pinmux_arr[] =3D {0x0c, 0x4,  // IO4 connected to QSPI
> > +             0x10, 0x4,      // IO5
> > +             0x14, 0x4,      // IO6
> > +             0x18, 0x4,      // IO7
> > +             0x1c, 0x4,      // IO8
> > +             0x20, 0x4,      // IO9
> > +             0x24, 0xf,      // IO10
> > +             0x28, 0xf,      // IO11
> > +             0x2c, 0xf,      // IO12
> > +             0x30, 0xf,      // IO13
> > +             0x34, 0xf,      // IO14
> > +             0x38, 0xf};     // IO15
> > +     u32 len, i, offset, value;
> > +
> > +     len =3D sizeof(pinmux_arr) / sizeof(u32);
> > +     for (i =3D 0; i < len; i +=3D 2) {
> > +             offset =3D pinmux_arr[i];
> > +             value =3D pinmux_arr[i + 1];
> > +             writel(value, ALTERA_PINMUX_OFFS + offset);
> > +     }
> > +}
> > +
> > +void altera_set_storage(int store)
>
> Should be static?
>
> > +{
> > +     unsigned int gpio_flash_sel;
> > +     unsigned int gpio_flash_oe;
> > +
> > +     if (store =3D=3D altera_current_storage)
> > +             return;
> > +
> > +     if (gpio_lookup_name("portb5", NULL, NULL, &gpio_flash_oe)) {
> > +             printf("ERROR: GPIO not found\n");
> > +             return;
> > +     }
> > +
> > +     if (gpio_request(gpio_flash_oe, "flash_oe")) {
> > +             printf("ERROR: GPIO request failed\n");
> > +             return;
> > +     }
> > +
> > +     if (gpio_lookup_name("portc6", NULL, NULL, &gpio_flash_sel)) {
> > +             printf("ERROR: GPIO not found\n");
> > +             return;
> > +     }
> > +
> > +     if (gpio_request(gpio_flash_sel, "flash_sel")) {
> > +             printf("ERROR: GPIO request failed\n");
> > +             return;
> > +     }
> > +
> > +     switch (store) {
> > +     case ALTERA_MMC:
> > +             set_mux_mmc();
> > +             gpio_direction_output(gpio_flash_sel, 0);
> > +             gpio_direction_output(gpio_flash_oe, 0);
> > +             altera_current_storage =3D ALTERA_MMC;
> > +             writel(MMC_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
> > +             break;
> > +     case ALTERA_EMMC:
> > +             set_mux_emmc();
> > +             gpio_direction_output(gpio_flash_sel, 1);
> > +             gpio_direction_output(gpio_flash_oe, 1);
> > +             altera_current_storage =3D ALTERA_EMMC;
> > +             writel(MMC_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
> > +             break;
> > +     case ALTERA_QSPI:
> > +             set_mux_qspi();
> > +             gpio_direction_output(gpio_flash_sel, 1);
> > +             gpio_direction_output(gpio_flash_oe, 0);
> > +             altera_current_storage =3D ALTERA_QSPI;
> > +             writel(QSPI_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE)=
;
> > +             break;
> > +     default:
> > +             altera_current_storage =3D ALTERA_NONE;
> > +             break;
> > +     }
> > +
> > +     gpio_free(gpio_flash_sel);
> > +     gpio_free(gpio_flash_oe);
> > +}
> > +
> > +int altera_set_storage_cmd(struct cmd_tbl *cmdtp, int flag,
> > +                        int argc, char * const argv[])
>
> Same?
>
> > +{
> > +     if (argc !=3D 2)
> > +             return CMD_RET_USAGE;
> > +
> > +     if (!strcmp(argv[1], "MMC"))
> > +             altera_set_storage(ALTERA_MMC);
> > +     else if (!strcmp(argv[1], "QSPI"))
> > +             altera_set_storage(ALTERA_QSPI);
> > +     else if (!strcmp(argv[1], "EMMC"))
> > +             altera_set_storage(ALTERA_EMMC);
> > +     else
> > +             return CMD_RET_USAGE;
> > +
> > +     return CMD_RET_SUCCESS;
> > +}
> > +
> > +U_BOOT_CMD(altera_set_storage, 2, 0, altera_set_storage_cmd,
> > +        "Set non volatile memory access",
> > +        "<MMC|QSPI|EMMC> - Set access for the selected memory device")=
;
> > +
> > +#endif
>
(...)
> The entire file seems to be for just adding the cmd. Perhaps rename this
> file to reflect that and have the Makefile only even build this when
> CONFIG_SPL_BUILD is not set.

Agree. I applied the above changes/fixed the above mentioned issues.
It looks cleaner now. I prepare this in the next version of
this patch set. Thank you for the hint. I would name it as
aa1_set_storage_cmd() is this ok?

(...)
> Also, the MAINTAINERS entry doesn't cover the documentation (which I'm
> glad to see being added at the start!) nor the clock driver.

Added.
