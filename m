Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B30BC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B29B86EE5;
	Tue, 31 Oct 2023 07:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a5aRvlXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC3286EC9; Tue, 31 Oct 2023 07:16:39 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA5F8709A
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=merlew4n6@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-540105dea92so8067612a12.2
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 23:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698732996; x=1699337796; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxsZxNcyYuW2xXFbIFS2StMKGpUo9CpWdZHbUBaSAC8=;
 b=a5aRvlXUSSRP/z/qsMnZJgDzYZKIMWbsZB3UpnEL0m/ktTyFkOKC8I6Ylt73F9tM0o
 0IPakU3cpNJHIt2zcJk9xbZn1Bkx6Zpy+xvesJU5IjQYUkf/CHCcmXwtgcurN1i99I/f
 fo6MjBHIElIkF7bSnUdmIKpHes4MnBFlBRB0fVbRX9M3CDkW8FzRejJXL0xKRCm0fpZB
 rJeH2npe2v6lEcOk3jJ/F1DQu6+vuqsytoI15k72V2jKxRC6OOGQW5ZDugHIdszjJb7p
 RQxJEdUAWEwS6IeAqqP9ScCdBa2Tz+LDg3+WofDyi2owLxCLAzyuN+CsvtUFzOaSvdbc
 O8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698732996; x=1699337796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxsZxNcyYuW2xXFbIFS2StMKGpUo9CpWdZHbUBaSAC8=;
 b=XLYvKmZ7bA6BTwJvHZBsw/8hkdqt9/bgUnw2h+9+OEfqhbImmxDqQiJg/uwqCAkmh4
 qYziNeXryJTPUuS3oh8B9D5K9nUSt/CaPRbs9xQFtpbakiIp/pxUP+KkYq7B19ndjDbf
 pBj5XHDZ5UtWT/BmyqIg7HZu8mkGK99/VTTTY/3QpAtt5e2I1o4W4MzpJ24e1PpjhcmP
 JZ/4/P4JIimBm8/GYzUtDTmh49ov5dRkfzOxzuI+cWm745jBKYNTl+xl9CwCbnaPaeMe
 sahrEjXeFMTheOby/lOd548oQbPYCREH/oVyUqkI9cedrr6SFYx8VfiVMwD5kCdRFFhC
 Mbcw==
X-Gm-Message-State: AOJu0YzyW2qcljXjgg0DxZH7OeJacOSOX0vxSIe0gLBsnr+2bZ3SFdnI
 LaYlGXwOfP4q5hvQTNDwqDjmQssQpC1AaRixJvqluZJ+rxAeURwe
X-Google-Smtp-Source: AGHT+IHsgQ6hMDA5kx16LElzfCVhVipyyuH95ESkvMMbB53W7gby9nAhovGp5/oV0YeKwYKhoHEGJyBA/2eGISHNpT4=
X-Received: by 2002:a50:9356:0:b0:543:55f4:58ce with SMTP id
 n22-20020a509356000000b0054355f458cemr1905090eda.13.1698732995250; Mon, 30
 Oct 2023 23:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231029084533.44607-1-heinrich.schuchardt@canonical.com>
 <20231029084533.44607-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231029084533.44607-3-heinrich.schuchardt@canonical.com>
From: merle w <merlew4n6@gmail.com>
Date: Tue, 31 Oct 2023 14:16:22 +0800
Message-ID: <CAJ8bkywF8v+JA8D=di=agqmvdsUdrmUvhyeb16_4dDr07A0ejg@mail.gmail.com>
Subject: Re: [RFC v2 2/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Anup Patel <apatel@ventanamicro.com>, 
 Kautuk Consul <kconsul@ventanamicro.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
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

drivers/rng/riscv_zkr_rng.c:10:10: fatal error: interrupt.h: No such
file or directory
10 | #include <interrupt.h>
| ^~~~~~~~~~~~~
compilation terminated.

Where is this interrupt.h?

Regards,
Xiang W

Heinrich Schuchardt <heinrich.schuchardt@canonical.com> =E4=BA=8E2023=E5=B9=
=B410=E6=9C=8829=E6=97=A5=E5=91=A8=E6=97=A5 16:46=E5=86=99=E9=81=93=EF=BC=
=9A
>
> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
> provides an interface to a physical entropy source.
>
> A RNG driver based on the seed CSR is provided. It depends on
> mseccfg.sseed being set in the SBI firmware.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Resume after exception if seed CSR cannot be read.
> ---
>  drivers/rng/Kconfig         |   8 +++
>  drivers/rng/Makefile        |   1 +
>  drivers/rng/riscv_zkr_rng.c | 116 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 drivers/rng/riscv_zkr_rng.c
>
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index 994cc35b27..4f6e367169 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -48,6 +48,14 @@ config RNG_OPTEE
>           accessible to normal world but reserved and used by the OP-TEE
>           to avoid the weakness of a software PRNG.
>
> +config RNG_RISCV_ZKR
> +       bool "RISC-V Zkr random number generator"
> +       depends on RISCV_SMODE
> +       help
> +         This driver provides a Random Number Generator based on the
> +         Zkr RISC-V ISA extension which provides an interface to an
> +         NIST SP 800-90B or BSI AIS-31 compliant physical entropy source=
.
> +
>  config RNG_STM32
>         bool "Enable random number generator for STM32"
>         depends on ARCH_STM32 || ARCH_STM32MP
> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> index 47b323e61e..a5d3ca4130 100644
> --- a/drivers/rng/Makefile
> +++ b/drivers/rng/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_RNG_MSM) +=3D msm_rng.o
>  obj-$(CONFIG_RNG_NPCM) +=3D npcm_rng.o
>  obj-$(CONFIG_RNG_OPTEE) +=3D optee_rng.o
>  obj-$(CONFIG_RNG_STM32) +=3D stm32_rng.o
> +obj-$(CONFIG_RNG_RISCV_ZKR) +=3D riscv_zkr_rng.o
>  obj-$(CONFIG_RNG_ROCKCHIP) +=3D rockchip_rng.o
>  obj-$(CONFIG_RNG_IPROC200) +=3D iproc_rng200.o
>  obj-$(CONFIG_RNG_SMCCC_TRNG) +=3D smccc_trng.o
> diff --git a/drivers/rng/riscv_zkr_rng.c b/drivers/rng/riscv_zkr_rng.c
> new file mode 100644
> index 0000000000..8c9e111e2e
> --- /dev/null
> +++ b/drivers/rng/riscv_zkr_rng.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * The RISC-V Zkr extension provides CSR seed which provides access to a
> + * random number generator.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RNG
> +
> +#include <dm.h>
> +#include <interrupt.h>
> +#include <log.h>
> +#include <rng.h>
> +
> +#define DRIVER_NAME "riscv_zkr"
> +
> +enum opst {
> +       /** @BIST: built in self test running */
> +       BIST =3D 0b00,
> +       /** @WAIT: sufficient amount of entropy is not yet available */
> +       WAIT =3D 0b01,
> +       /** @ES16: 16bits of entropy available */
> +       ES16 =3D 0b10,
> +       /** @DEAD: unrecoverable self-test error */
> +       DEAD =3D 0b11,
> +};
> +
> +static unsigned long read_seed(void)
> +{
> +       unsigned long ret;
> +
> +       __asm__ __volatile__("csrrw %0, seed, x0" : "=3Dr" (ret) : : "mem=
ory");
> +
> +       return ret;
> +}
> +
> +static int riscv_zkr_read(struct udevice *dev, void *data, size_t len)
> +{
> +       u8 *ptr =3D data;
> +
> +       while (len) {
> +               u32 val;
> +
> +               val =3D read_seed();
> +
> +               switch (val >> 30) {
> +               case BIST:
> +                       continue;
> +               case WAIT:
> +                       continue;
> +               case ES16:
> +                       *ptr++ =3D val & 0xff;
> +                       if (--len) {
> +                               *ptr++ =3D val >> 8;
> +                               --len;
> +                       }
> +                       break;
> +               case DEAD:
> +                       return -ENODEV;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * riscv_zkr_probe() - check if the seed register is available
> + *
> + * If the SBI software has not set mseccfg.sseed=3D1 or the Zkr
> + * extension is not available this probe function will result
> + * in an exception. Currently we cannot recover from this.
> + *
> + * @dev:       RNG device
> + * Return:     0 if successfully probed
> + */
> +static int riscv_zkr_probe(struct udevice *dev)
> +{
> +       struct resume_data resume;
> +       int ret;
> +       u32 val;
> +
> +       /* Check if reading seed leads to interrupt */
> +       set_resume(&resume);
> +       ret =3D setjmp(resume.jump);
> +       if (ret)
> +               log_debug("Exception %ld reading seed CSR\n", resume.code=
);
> +       else
> +               val =3D read_seed();
> +       set_resume(NULL);
> +       if (ret)
> +               return -ENODEV;
> +
> +       do {
> +               val =3D read_seed();
> +               val >>=3D 30;
> +       } while (val =3D=3D BIST || val =3D=3D WAIT);
> +
> +       if (val =3D=3D DEAD)
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
> +static const struct dm_rng_ops riscv_zkr_ops =3D {
> +       .read =3D riscv_zkr_read,
> +};
> +
> +U_BOOT_DRIVER(riscv_zkr) =3D {
> +       .name =3D DRIVER_NAME,
> +       .id =3D UCLASS_RNG,
> +       .ops =3D &riscv_zkr_ops,
> +       .probe =3D riscv_zkr_probe,
> +};
> +
> +U_BOOT_DRVINFO(cpu_riscv_zkr) =3D {
> +       .name =3D DRIVER_NAME,
> +};
> --
> 2.40.1
>
