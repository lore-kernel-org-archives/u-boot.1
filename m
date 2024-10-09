Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730EACEDD97
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 13:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B8289229;
	Wed,  9 Oct 2024 15:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XljitVMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7468922B; Wed,  9 Oct 2024 15:50:18 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 885F5891F1
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 15:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fac275471dso8976661fa.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728481815; x=1729086615; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VeKyTmgEKq3XdCHdF7vO/gqYPIjgUYH7UOMxZbFUhT8=;
 b=XljitVMzHYalyxndZgjpbjrMRiZzVlqeR2y+5mWp/7dnJEG/SvbeMe4elFiHgc1kQO
 vk8HDcRdSdfUpn4Y6+pqcS1gCObd+H/7hS2LTu/aPZEwO29eYfc0myfrZBJo/qnsjD8M
 7GnIjLrLzmhn9qVcYdyC998w1KwbrXmjvgH07RrW7nlO9PD396oa0RjmkmDKWzNV0ypy
 plD1pSk6kCJhlBpXcGdaXyFsegaXaEEcZ5ZZ6shIjoK5LHm3U8ioz0tIrARwgn3tLtSs
 IEdnC9VJdcxUAeA9rrdTFbxEuoFbxCnJ1P3Dcd/YBfFSvW+9kXOnd1tx0c9HO+xmakSF
 pTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728481815; x=1729086615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VeKyTmgEKq3XdCHdF7vO/gqYPIjgUYH7UOMxZbFUhT8=;
 b=JnhA/O7GAWldowXF5GStdaMeg882yW0VKtxmtxtmHnhREUlUlp/PjN+eceP+NJIzGp
 YS4WzrHvxaG2X2aqX9oS50tKVmH4Jh73I3vrA4Aaef8vr/2mcPSEYHF3Qp/n//h6fmjd
 ved8on6miKDUCgH7QUW651qcPsIwAEZwokOQBjECQX3P7x6Lfzrik7Wx4ueVKgbOmS/B
 1qH84bFiqVwUZOZUEsjtUI4QVzcdUUo7npdfpbGkb0tVba6gE6XOK3ER4LO1mpIIGL9r
 uIjO8ENxCIZaxbRasla0BDCLuuIhDmNRUyIYZcRIZD+L6ansr7mUjDmammjxgw0Uufq2
 DdpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWF1il/mcHF3NrkKIBXVxCK9+ihgKoQPJ9w/1cNKqUKLnIwaDHHzG7j6wOwL9zPYsOxTpqdTo=@lists.denx.de
X-Gm-Message-State: AOJu0YzCfGuJo5KNi9SmjQy3zACcNs2I9OKzMRFUgNb3NaDt+sGgKqqi
 Yl2k0KCyK86H6gJcwJDpTFgHqRwI/Fwsic6DAdxwOIjM6oY2MHnYwDO9Bv3Xd6oul3PGF8qyMNh
 m1RthgITWWH4OSRLbFiTsl77LDPg=
X-Google-Smtp-Source: AGHT+IGxzZ0OV3+egcHzsZ+UQqrDFtzhExQJilFCeJXJdjV2/lOVhO3GY/OhJJQwXoU8SAmWVcMlKKWzwKx1u4njBhQ=
X-Received: by 2002:a2e:be8c:0:b0:2fa:cfba:fb65 with SMTP id
 38308e7fff4ca-2fb0de6977cmr23425711fa.3.1728481814470; Wed, 09 Oct 2024
 06:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241009-imx93qsb-v1-0-50a4ac53ccc4@nxp.com>
 <20241009-imx93qsb-v1-2-50a4ac53ccc4@nxp.com>
In-Reply-To: <20241009-imx93qsb-v1-2-50a4ac53ccc4@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 9 Oct 2024 10:50:02 -0300
Message-ID: <CAOMZO5D43j6qRuzSd2hC+JRdQav6YT135vd7ioVMOVd+czhkZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx: Support i.MX93 9X9 QSB board
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

On Wed, Oct 9, 2024 at 4:27=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:

> +&usdhc2 {
> +       bootph-pre-ram;
> +       bootph-some-ram;
> +       fsl,signal-voltage-switch-extra-delay-ms =3D <8>;

Why is 'fsl,signal-voltage-switch-extra-delay-ms' a U-Boot-only property?

How does kernel handle usdhc2 without this property?

> +#include <usb.h>
> +#include <dwc3-uboot.h>

I don't see USB support in this file.

> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define UART_PAD_CTRL  (PAD_CTL_DSE(6) | PAD_CTL_FSEL2)
> +#define WDOG_PAD_CTRL  (PAD_CTL_DSE(6) | PAD_CTL_ODE | PAD_CTL_PUE | PAD=
_CTL_PE)
> +
> +static iomux_v3_cfg_t const uart_pads[] =3D {
> +       MX93_PAD_UART1_RXD__LPUART1_RX | MUX_PAD_CTRL(UART_PAD_CTRL),
> +       MX93_PAD_UART1_TXD__LPUART1_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
> +};
> +
> +int board_early_init_f(void)
> +{
> +       imx_iomux_v3_setup_multiple_pads(uart_pads, ARRAY_SIZE(uart_pads)=
);

With DM_SERIAL, there is no need for UART board code and watchdog
IOMUX settings.


> +int board_phy_config(struct phy_device *phydev)
> +{
> +       if (phydev->drv->config)
> +               phydev->drv->config(phydev);

Is this really needed?

> +       val =3D ret;
> +
> +       if (is_voltage_mode(VOLT_LOW_DRIVE)) {
> +               buck_val =3D 0x0c; /* 0.8v for Low drive mode */

The unit for Volt is V with a capital letter. Please fix it globally.

> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +imx93_9x9_qsb
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +U-Boot for the NXP i.MX93 Quick Starter Board

In the commit log you put "Quick Start". Please be consistent.

> +Build U-Boot
> +------------
> +
> +.. code-block:: bash
> +
> +   $ export CROSS_COMPILE=3Daarch64-poky-linux-
> +   $ make imx93_9x9_qsb_defconfig

Please also explain when imx93_9x9_qsb_inline_ecc_defconfig could be
used, the difference between the two defconfigs, etc.

> +config IMX9_DRAM_INLINE_ECC
> +       bool "Enable DDR INLINE ECC feature"
> +       default n

default n is already the default. Just remove it.

> +/* Initial environment variables */
> +#define CFG_EXTRA_ENV_SETTINGS         \
> +       BOOTENV \
> +       "prepare_mcore=3Dsetenv mcore_clk clk-imx93.mcore_booted;\0" \
> +       "scriptaddr=3D0x83500000\0" \
> +       "kernel_addr_r=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> +       "image=3DImage\0" \

Please move it to a .env file instead.
