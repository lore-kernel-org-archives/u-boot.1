Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE13DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 13:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D2AA87D5F;
	Mon, 15 Apr 2024 15:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="EvU9kJug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D5C87D5F; Mon, 15 Apr 2024 15:05:41 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3139879F3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 15:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2a68a2b3747so1791164a91.3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713186335; x=1713791135; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XisRzN+LnW6pNqtkWyBqBQEtTr+nLABjF5TSDn/NOI=;
 b=EvU9kJugIYlm1Z2j7zWzuWQdjPe3cBLivitdwSLAwF5XGzNTg2+uW+0nPwn85My/fs
 6C747gYuxX/n4ZnIWbeK5K7OyeFNLAOTMvmWz3naohGBxx2j9tHTzmO02iLIOat1s0oa
 6s1DfQA2fnpDLXgsMiJY8siRMwgCYqnoynBhMRO7I5S5JzIw68HFIWQynmCsollm+TCb
 6uwIQjnyUkglp9Gww3PHDfvcLdzTXO8xWh3Lq7KEFn0jxMMqA6cwDtjtTim2MIEhcnZo
 45vlhwceQyecMrhcTQV4mAYd85OywPGw1TXbl1a1rfu2tVukv5eWcHkkcFi60+YMsUZe
 OSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713186335; x=1713791135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0XisRzN+LnW6pNqtkWyBqBQEtTr+nLABjF5TSDn/NOI=;
 b=aP/1RPfSC/igN58AUsNUKUVi9ue9s3ZVjt7q+TDGCJ1T/AK9GuwTe3y6Npv3l8Jbj5
 n3vgRbrhNeg/NeaL9ibfR14wfpjbjbZgZ+JDiAyziAryrJi4g0Nn3JkWRzkLdEu8WnJ3
 uBC5NNcGys/h6SZ0l8uwcQAhl7Py5L9TkYR1GHBKjrH9hBMq1LU0U0xxmdjsvHJUjCWY
 1wOjRCB8JUalf3Ubry1m+ZNuy/v31z3YwYKgEL6eEn6hP79TL56+rOR27D6Re3C21cr9
 hwGAE0EBMORQA01eLytnXcntdPMZ03cpAYYomqD75n4mF95PiSXjY7c+MXDwkXGhYJkX
 EQKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6nRU3PNJ3cQgq23nAsvuFEG+k7o6b4Gcxd71cdz0t4Dg4yaIEOlQMtwlsyPjVn+W3cjkbYks7qoVvCj2WN6EQqjxdLw==
X-Gm-Message-State: AOJu0Yxwn8ao7PaHlbiLY6tr+W5cZaccElqiWEiYR4JrY4xlNWNFtrWE
 T1Ctx1DqNMwIH9LdN7rPByR64zIDKjL0TJxDP8eeZtKfQuX2BGW7s/RI1wPUoKhdsGcgMpvuuSq
 1AQTWJk6dqp+KCwTYaANAx4kD50CtOTlelSzazw==
X-Google-Smtp-Source: AGHT+IHQFY3e5f5IxkMXntzq2/yCHMJzHapx39KxBXaBIe6NkamnGql+icxAM/wy8aV+NjCmWCzEjOW6wvXkluHsuY8=
X-Received: by 2002:a17:90b:1b47:b0:2a2:70c6:970c with SMTP id
 nv7-20020a17090b1b4700b002a270c6970cmr7763059pjb.11.1713186335075; Mon, 15
 Apr 2024 06:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240415-b4-msm-serial-bitrate-v1-0-5a89f84fd9e7@linaro.org>
 <20240415-b4-msm-serial-bitrate-v1-3-5a89f84fd9e7@linaro.org>
In-Reply-To: <20240415-b4-msm-serial-bitrate-v1-3-5a89f84fd9e7@linaro.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 15 Apr 2024 15:05:23 +0200
Message-ID: <CA+HBbNH_mGrFPDt+74r+TOveWmE_wQx4CYy-BGtJa76T6TUJ=A@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: msm: calculate bit clock divider
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Mon, Apr 15, 2024 at 2:44=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> The driver currently requires the bit clock divider be hardcoded in
> devicetree (or use the hardcoded default from apq8016).
>
> The bit clock divider is used to derive the baud rate from the core
> clock:
>
>   baudrate =3D clk_rate / csr_div
>
> clk_rate is the actual programmed core clock rate which is returned by
> clk_set_rate(), and this UART driver only supports a baudrate of 115200.
> We can therefore determine the appropriate value for UARTDM_CSR by
> iterating over the possible values and finding the one where the
> equation above holds true for a baudrate of 115200.
>
> Implement this logic and drop the non-standard DT bindings for this
> driver.
>
> Tested on dragonboard410c.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Works on Alfa AP120C (IPQ4018) with full DM UART, but debug UART
prints junk since .clk_rate =3D 7372800 is not correct for IPQ40xx.
I would suggest using .clk_rate =3D CONFIG_VAL(DEBUG_UART_CLOCK) instead
to populate the value per board, this also avoids per ARCH ifdefs.

Regards,
Robert
> ---
> Cc: Robert Marko <robert.marko@sartura.hr>
> ---
>  doc/device-tree-bindings/serial/msm-serial.txt | 10 ---
>  drivers/serial/serial_msm.c                    | 87 ++++++++++++++++++++=
+-----
>  2 files changed, 70 insertions(+), 27 deletions(-)
>
> diff --git a/doc/device-tree-bindings/serial/msm-serial.txt b/doc/device-=
tree-bindings/serial/msm-serial.txt
> deleted file mode 100644
> index dca995798a90..000000000000
> --- a/doc/device-tree-bindings/serial/msm-serial.txt
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -Qualcomm UART (Data Mover mode)
> -
> -Required properties:
> -- compatible: must be "qcom,msm-uartdm-v1.4"
> -- reg: start address and size of the registers
> -- clock: interface clock (must accept baudrate as a frequency)
> -
> -Optional properties:
> -- bit-rate: Data Mover bit rate register value
> -                       (If not defined then 0xCC is used as default)
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index 8044d38518db..e461929b4338 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -31,8 +31,18 @@
>  #define UARTDM_RXFS_BUF_SHIFT   0x7  /* Number of bytes in the packing b=
uffer */
>  #define UARTDM_RXFS_BUF_MASK    0x7
>  #define UARTDM_MR1                              0x00
>  #define UARTDM_MR2                              0x04
> +/*
> + * This is documented on page 1817 of the apq8016e technical reference m=
anual.
> + * section 6.2.5.3.26
> + *
> + * The upper nybble contains the bit clock divider for the RX pin, the l=
ower
> + * nybble defines the TX pin. In almost all cases these should be the sa=
me value.
> + *
> + * The baud rate is the core clock frequency divided by the fixed divide=
r value
> + * programmed into this register (defined in calc_csr_bitrate()).
> + */
>  #define UARTDM_CSR                              0xA0
>
>  #define UARTDM_SR                0xA4 /* Status register */
>  #define UARTDM_SR_RX_READY       (1 << 0) /* Word is the receiver FIFO *=
/
> @@ -52,9 +62,8 @@
>
>  #define UARTDM_TF               0x100 /* UART Transmit FIFO register */
>  #define UARTDM_RF               0x140 /* UART Receive FIFO register */
>
> -#define UART_DM_CLK_RX_TX_BIT_RATE 0xCC
>  #define MSM_BOOT_UART_DM_8_N_1_MODE 0x34
>  #define MSM_BOOT_UART_DM_CMD_RESET_RX 0x10
>  #define MSM_BOOT_UART_DM_CMD_RESET_TX 0x20
>
> @@ -63,9 +72,9 @@ DECLARE_GLOBAL_DATA_PTR;
>  struct msm_serial_data {
>         phys_addr_t base;
>         unsigned chars_cnt; /* number of buffered chars */
>         uint32_t chars_buf; /* buffered chars */
> -       uint32_t clk_bit_rate; /* data mover mode bit rate register value=
 */
> +       uint32_t clk_rate; /* core clock rate */
>  };
>
>  static int msm_serial_fetch(struct udevice *dev)
>  {
> @@ -155,34 +164,63 @@ static const struct dm_serial_ops msm_serial_ops =
=3D {
>         .pending =3D msm_serial_pending,
>         .getc =3D msm_serial_getc,
>  };
>
> -static int msm_uart_clk_init(struct udevice *dev)
> +static long msm_uart_clk_init(struct udevice *dev)
>  {
> -       uint clk_rate =3D fdtdec_get_uint(gd->fdt_blob, dev_of_offset(dev=
),
> -                                       "clock-frequency", 115200);
> +       struct msm_serial_data *priv =3D dev_get_priv(dev);
>         struct clk clk;
>         int ret;
> +       long rate;
>
>         ret =3D clk_get_by_name(dev, "core", &clk);
>         if (ret < 0) {
>                 pr_warn("%s: Failed to get clock: %d\n", __func__, ret);
> -               return ret;
> +               return 0;
>         }
>
> -       ret =3D clk_set_rate(&clk, clk_rate);
> -       if (ret < 0)
> -               return ret;
> +       rate =3D clk_set_rate(&clk, priv->clk_rate);
>
> -       return 0;
> +       return rate;
> +}
> +
> +static int calc_csr_bitrate(struct msm_serial_data *priv)
> +{
> +       /* This table is from the TRE. See the definition of UARTDM_CSR *=
/
> +       unsigned int csr_div_table[] =3D {24576, 12288, 6144, 3072, 1536,=
 768, 512, 384,
> +                                       256,   192,   128,  96,   64,   4=
8,  32,  16};
> +       int i =3D ARRAY_SIZE(csr_div_table) - 1;
> +       /* Currently we only support one baudrate */
> +       int baud =3D 115200;
> +
> +       for (; i >=3D 0; i--) {
> +               int x =3D priv->clk_rate / csr_div_table[i];
> +
> +               if (x =3D=3D baud)
> +                       /* Duplicate the configuration for RX
> +                        * as the lower nybble only configures TX
> +                        */
> +                       return i + (i << 4);
> +       }
> +
> +       return -EINVAL;
>  }
>
>  static void uart_dm_init(struct msm_serial_data *priv)
>  {
>         /* Delay initialization for a bit to let pins stabilize if necess=
ary */
>         mdelay(5);
> +       int bitrate =3D calc_csr_bitrate(priv);
> +       if (bitrate < 0) {
> +               log_warning("Couldn't calculate bit clock divider! Using =
default\n");
> +               /* This happens to be the value used on MSM8916 for the h=
ardcoded clockrate
> +                * in clock-apq8016. It's at least a better guess than a =
value we *know*
> +                * is wrong...
> +                */
> +               bitrate =3D 0xCC;
> +       }
>
> -       writel(priv->clk_bit_rate, priv->base + UARTDM_CSR);
> +       writel(bitrate, priv->base + UARTDM_CSR);
>         writel(0x0, priv->base + UARTDM_MR1);
>         writel(MSM_BOOT_UART_DM_8_N_1_MODE, priv->base + UARTDM_MR2);
>         writel(MSM_BOOT_UART_DM_CMD_RESET_RX, priv->base + UARTDM_CR);
>         writel(MSM_BOOT_UART_DM_CMD_RESET_TX, priv->base + UARTDM_CR);
> @@ -191,18 +229,27 @@ static void uart_dm_init(struct msm_serial_data *pr=
iv)
>         writel(0x0, priv->base + UARTDM_DMEN);
>  }
>  static int msm_serial_probe(struct udevice *dev)
>  {
> -       int ret;
>         struct msm_serial_data *priv =3D dev_get_priv(dev);
> +       long rate;
>
>         /* No need to reinitialize the UART after relocation */
>         if (gd->flags & GD_FLG_RELOC)
>                 return 0;
>
> -       ret =3D msm_uart_clk_init(dev);
> -       if (ret)
> -               return ret;
> +       rate =3D msm_uart_clk_init(dev);
> +       if (rate < 0)
> +               return rate;
> +       if (!rate) {
> +               log_err("Got core clock rate of 0... Please fix your cloc=
k driver\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Update the clock rate to the actual programmed rate returned b=
y the
> +        * clock driver
> +        */
> +       priv->clk_rate =3D rate;
>
>         uart_dm_init(priv);
>
>         return 0;
> @@ -210,15 +257,20 @@ static int msm_serial_probe(struct udevice *dev)
>
>  static int msm_serial_of_to_plat(struct udevice *dev)
>  {
>         struct msm_serial_data *priv =3D dev_get_priv(dev);
> +       int ret;
>
>         priv->base =3D dev_read_addr(dev);
>         if (priv->base =3D=3D FDT_ADDR_T_NONE)
>                 return -EINVAL;
>
> -       priv->clk_bit_rate =3D fdtdec_get_int(gd->fdt_blob, dev_of_offset=
(dev),
> -                                                       "bit-rate", UART_=
DM_CLK_RX_TX_BIT_RATE);
> +       ret =3D dev_read_u32(dev, "clock-frequency", &priv->clk_rate);
> +       if (ret < 0) {
> +               log_debug("No clock frequency specified, using default ra=
te\n");
> +               /* Default for APQ8016 */
> +               priv->clk_rate =3D 7372800;
> +       }
>
>         return 0;
>  }
>
> @@ -241,8 +293,9 @@ U_BOOT_DRIVER(serial_msm) =3D {
>  #ifdef CONFIG_DEBUG_UART_MSM
>
>  static struct msm_serial_data init_serial_data =3D {
>         .base =3D CONFIG_VAL(DEBUG_UART_BASE),
> +       .clk_rate =3D 7372800,
>  };
>
>  #include <debug_uart.h>
>
>
> --
> 2.44.0
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
