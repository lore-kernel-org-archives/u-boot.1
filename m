Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FDFD49209
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C848945E;
	Mon, 18 Nov 2024 11:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="mTSQFQH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A5089466; Mon, 18 Nov 2024 11:39:55 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 849388945E
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2feeb1e8edfso20892391fa.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 02:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1731926393; x=1732531193; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDpHvOkpsJlv59xt4qj4Yf90HqORsaail91PuWmhtxs=;
 b=mTSQFQH1gBM/d05fSHPHdHSag3TspbDtin30MlD9gx5iirmxeQFaRfG5qg8qU3uvbK
 e1KVkMU0DNDXAGcB/6yUvsvYG8BlUAlpJMSBuqBhl9Jo0VZ0u2OpP9eftCGdGn4Q0wsF
 LULiZ2Tqv3usuWk0VIPVXVqG5DETaylGpkHevC7pkwMQ7eFFfdYZdjCsAYIUzzug1fUT
 kOdqF3C0RuvdUWgM2Ba1tUUdahH0j9H7FsD9vmnUutLAARIvEEUOW8dlxgxzQshIa0Ky
 Lxz6gLKgSCyeE48qO0+jjuZkuTn4tWeQr+5yQYY+8Xb/AuY2LIFHBSEps9yDOIh/GKZk
 lBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731926393; x=1732531193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDpHvOkpsJlv59xt4qj4Yf90HqORsaail91PuWmhtxs=;
 b=T9DqC6WIWHSG1pQGlwevuKU5/gy1zwbOJNDvDW0z7sP0OeimV1FT/QByZQ8++cSMav
 SFrbzXbhkC11wWodSJKtx9AviOUoTnD9wYdaPcaRa7lvyMtnklT0xqw1FDMIA1/ORUHG
 FkAhlx/vqKFMG6yROGrb2l3lGBEfEXT0ovC7aNzXBm5LRY3Gs+SplhjqYFuCBs1FLJ9q
 aMhPZNpXYrc2BHCqGiZEdBK+1XnSQwaiqA3RzwXFTRTGvqq9hZEIQj0Cq7j24V0nHiE4
 b2qesa1s8F+kSrSqLQSEuSFmxqZyRZXwHCwyvc6oID58Pv2T7XvBJaXwfNYQbToXZPJV
 AAdw==
X-Gm-Message-State: AOJu0YzpCQttBnQEFQ/vZUBoNoOD4p9DoNdwSRNj82++41bixhQvmyXm
 rL3di4cBEOAB9Q8H7rROreOtv7dX37AajLQY8MSGhi3SdshIO26Hhh3PmOTLB5CDMdJP8oXJ5Nz
 RjbOSHhPkzTo9pmKILBG5lniN7njp3EP2p5C94A==
X-Google-Smtp-Source: AGHT+IEc1mW+IJelHMUwPkxG8G4pPe6zCqB1TirLgBr1pblIgvKCMN2Yh8BcIMqxhhc+lIXH5aGJ3O1R89zxf9HOjSs=
X-Received: by 2002:a2e:a914:0:b0:2f7:7be8:fd89 with SMTP id
 38308e7fff4ca-2ff6061066bmr77232901fa.6.1731926392776; Mon, 18 Nov 2024
 02:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20241118062715.32989-1-hs@denx.de>
 <20241118062715.32989-2-hs@denx.de>
In-Reply-To: <20241118062715.32989-2-hs@denx.de>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Mon, 18 Nov 2024 11:39:36 +0100
Message-ID: <CAL6CDMF=z+wH1xhfwVj=yUBdPe+zQ=odi_FtQsXbR832JaXW8g@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] wdt: imx8qxp: add option to control external
 PMIC wdt via IMX8 SCU
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Enrico Leto <enrico.leto@siemens.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andrej Valek <andrej.valek@siemens.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 CL Wang <cl634@andestech.com>, 
 Chanho Park <chanho61.park@samsung.com>, Fabio Estevam <festevam@denx.de>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Randolph <randolph@andestech.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, 
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
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

Hello Heiko,

some nitpicks below:

On Mon, Nov 18, 2024 at 7:27=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> Driver for a PMIC watchdog timer controlled via Siemens SCU firmware
> extensions. Only useful on some Siemens i.MX8-based platforms as
> special SCFW is needed which provides the needed SCU API.
>
> Signed-off-by: Andrej Valek <andrej.valek@siemens.com>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
>
> Changes in v2:
> - work on comments from Stefan:
>   - rename driver file from scu_wdt.c to scu_pmic_wdt.c
>   - rename Kconfig symbol from CONFIG_WDT_IMX_SCU to CONFIG_WDT_SCU_PMIC
>   - reworked Kconfig help text
>   - add comment that TIMER_FUNC_CTRL_PMIC_WDOG is a siemens specific
>     SCU API extension in their SCFW.
>   - reworked commit message
>
>  drivers/misc/imx8/scu_api.c     | 21 ++++++++++++
>  drivers/watchdog/Kconfig        |  7 ++++
>  drivers/watchdog/Makefile       |  1 +
>  drivers/watchdog/scu_pmic_wdt.c | 59 +++++++++++++++++++++++++++++++++
>  include/firmware/imx/sci/rpc.h  |  3 ++
>  include/firmware/imx/sci/sci.h  |  1 +
>  6 files changed, 92 insertions(+)
>  create mode 100644 drivers/watchdog/scu_pmic_wdt.c
>
> diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
> index 591d71b096a..edb6923151a 100644
> --- a/drivers/misc/imx8/scu_api.c
> +++ b/drivers/misc/imx8/scu_api.c
> @@ -951,6 +951,27 @@ int sc_timer_set_wdog_window(sc_ipc_t ipc, sc_timer_=
wdog_time_t window)
>         return ret;
>  }
>
> +int sc_timer_control_pmic_wdog(sc_ipc_t ipc, u8 cmd)
> +{
> +       struct udevice *dev =3D gd->arch.scu_dev;
> +       struct sc_rpc_msg_s msg;
> +       int size =3D sizeof(struct sc_rpc_msg_s);
> +       int ret;
> +
> +       RPC_VER(&msg) =3D SC_RPC_VERSION;
> +       RPC_SVC(&msg) =3D (u8)SC_RPC_SVC_TIMER;
> +       RPC_FUNC(&msg) =3D (u8)TIMER_FUNC_CTRL_PMIC_WDOG;
> +       RPC_U8(&msg, 0U) =3D (u8)cmd;
> +       RPC_SIZE(&msg) =3D 2U;
> +
> +       ret =3D misc_call(dev, SC_FALSE, &msg, size, &msg, size);
> +       if (ret)
> +               printf("%s: res:%d\n",
> +                      __func__, RPC_R8(&msg));
> +
> +       return ret;
> +}
> +
>  int sc_seco_authenticate(sc_ipc_t ipc, sc_seco_auth_cmd_t cmd,
>                          sc_faddr_t addr)
>  {
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0e45f0a0922..f317d0922cb 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -428,6 +428,13 @@ config WDT_ARM_SMC
>           Select this to enable Arm SMC watchdog timer. This watchdog wil=
l manage
>           a watchdog based on ARM SMCCC communication.
>
> +config WDT_SCU_PMIC
> +       bool "Enable PMIC Watchdog Timer support for siemens platforms"

s/siemens/Siemens/g

> +       depends on IMX8 && WDT
depends on ARCH_IMX8 && WDT ?
IMX8 Kconfig symbol implies additional dependency on CAAM module,
which is not the case with this driver.

> +       help
> +         Select this to enable the PMIC watchdog driver controlled via
> +         IMX8 SCU API found on Siemens platforms.
> +
>  config SPL_WDT
>         bool "Enable driver model for watchdog timer drivers in SPL"
>         depends on SPL_DM
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 0b107c008f7..fed924f7e01 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_WDT_OCTEONTX) +=3D octeontx_wdt.o
>  obj-$(CONFIG_WDT_OMAP3) +=3D omap_wdt.o
>  obj-$(CONFIG_WDT_SBSA) +=3D sbsa_gwdt.o
>  obj-$(CONFIG_WDT_K3_RTI) +=3D rti_wdt.o
> +obj-$(CONFIG_WDT_SCU_PMIC) +=3D scu_pmic_wdt.o
>  obj-$(CONFIG_WDT_SL28CPLD) +=3D sl28cpld-wdt.o
>  obj-$(CONFIG_WDT_SP805) +=3D sp805_wdt.o
>  obj-$(CONFIG_WDT_STARFIVE) +=3D starfive_wdt.o
> diff --git a/drivers/watchdog/scu_pmic_wdt.c b/drivers/watchdog/scu_pmic_=
wdt.c
> new file mode 100644
> index 00000000000..e7ca00de654
> --- /dev/null
> +++ b/drivers/watchdog/scu_pmic_wdt.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for a PMIC watchdog timer controlled via Siemens SCU firmware
> + * extensions. Only useful on some Siemens i.MX8-based platforms as
> + * special NXP SCFW is needed which provides the needed SCU API.
> + *
> + * Copyright (C) 2024 Siemens AG
> + */
> +
> +#include <dm.h>
> +#include <wdt.h>
> +#include <firmware/imx/sci/sci.h>
> +
> +/* watchdog commands */
> +#define CMD_START_WDT 0x55
> +#define CMD_STOP_WDT  0x45
> +#define CMD_PING_WDT  0x35
> +
> +static int scu_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flag=
s)
> +{
> +       /* start external watchdog via Timer API */
> +       return sc_timer_control_pmic_wdog(-1, CMD_START_WDT);
> +}
> +
> +static int scu_wdt_stop(struct udevice *dev)
> +{
> +       /* stop external watchdog via Timer API */
> +       return sc_timer_control_pmic_wdog(-1, CMD_STOP_WDT);
> +}
> +
> +static int scu_wdt_reset(struct udevice *dev)
> +{
> +       return sc_timer_control_pmic_wdog(-1, CMD_PING_WDT);
> +}
> +
> +static int scu_wdt_probe(struct udevice *dev)
> +{
> +       debug("%s(dev=3D%p)\n", __func__, dev);
> +       return 0;
> +}
> +
> +static const struct wdt_ops scu_wdt_ops =3D {
> +       .reset          =3D scu_wdt_reset,
> +       .start          =3D scu_wdt_start,
> +       .stop           =3D scu_wdt_stop,
> +};
> +
> +static const struct udevice_id scu_wdt_ids[] =3D {
> +       { .compatible =3D "siemens,scu-wdt" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(scu_wdt) =3D {
> +       .name           =3D "scu_wdt",
> +       .id             =3D UCLASS_WDT,
> +       .of_match       =3D scu_wdt_ids,
> +       .probe          =3D scu_wdt_probe,
> +       .ops            =3D &scu_wdt_ops,
> +};
> diff --git a/include/firmware/imx/sci/rpc.h b/include/firmware/imx/sci/rp=
c.h
> index 28adec2a8e1..6f16cf4a8b6 100644
> --- a/include/firmware/imx/sci/rpc.h
> +++ b/include/firmware/imx/sci/rpc.h
> @@ -231,4 +231,7 @@ struct sc_rpc_msg_s {
>  #define TIMER_FUNC_SET_SYSCTR_PERIODIC_ALARM 17U /* Index for sc_timer_s=
et_sysctr_periodic_alarm() RPC call */
>  #define TIMER_FUNC_CANCEL_SYSCTR_ALARM 18U /* Index for sc_timer_cancel_=
sysctr_alarm() RPC call */
>
> +/* siemens specific API extension from Siemens */
please drop one "siemens"
> +#define TIMER_FUNC_CTRL_PMIC_WDOG 20U  /*!< Index for sc_timer_ctrl_pmic=
_wdog() RPC call */
> +
>  #endif /* SC_RPC_H */
> diff --git a/include/firmware/imx/sci/sci.h b/include/firmware/imx/sci/sc=
i.h
> index 7d8499f070a..b971b62836d 100644
> --- a/include/firmware/imx/sci/sci.h
> +++ b/include/firmware/imx/sci/sci.h
> @@ -123,6 +123,7 @@ int sc_rm_set_master_sid(sc_ipc_t ipc, sc_rsrc_t reso=
urce, sc_rm_sid_t sid);
>
>  /* Timer API */
>  int sc_timer_set_wdog_window(sc_ipc_t ipc, sc_timer_wdog_time_t window);
> +int sc_timer_control_pmic_wdog(sc_ipc_t ipc, u8 cmd);
>
>  /* SECO API */
>  int sc_seco_authenticate(sc_ipc_t ipc, sc_seco_auth_cmd_t cmd,
> --
> 2.20.1
>


--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
