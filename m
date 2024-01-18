Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB60C47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 19:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1383387BD0;
	Thu, 18 Jan 2024 20:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vn3IDVDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D3F87BCC; Thu, 18 Jan 2024 20:54:42 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51ECB87BB6
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 20:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-210aa8141a0so48545fac.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 11:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705607677; x=1706212477; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvAUoKbZbGUuhIgLOy8LMR4FwRIHH/qcC8K21xwFjhQ=;
 b=Vn3IDVDQngZdkDbH8QsisjKTyo96sMi8+eurAU0I698IVmkSV+MWW6oYe18b5K1MJc
 H7pQQYXBDtDuI264GVy4ZTrtwRERh73nep/re8Uyxar0R8wydbGo6rzo8VZA1lGNm31C
 Uv3NaoPpE0H1OvWRGGOamqrdNn14zPUrv5uVW+8uFZvgtQv+BkpjIU0NUq4yJ+Hfy2NU
 OJAaySy+DFOv5RCmJOXos7B0u0+XutwciWovlHJF/ujL/ggisooKCs2P35dtwYun+WBg
 a6WSMVcJ3skG4tS5/C8IIkRDypGqnPoOYpkvWxRIfUkexVVaUn4OJ7EN2jLL1ysfmHsf
 5a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705607677; x=1706212477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvAUoKbZbGUuhIgLOy8LMR4FwRIHH/qcC8K21xwFjhQ=;
 b=eIn8s2WknFrOhMOHSEm26Q0kn5Yosj3rzrWaHIMbFfQMifUfIsqOCLDbXgOevyD41v
 javzs4+s92vkM68hsHriYX0H/YdSqNmfkcSadGOGPyYMguBNeUkzhO4sYB20GVYhdLsX
 rRTr0ulJLWlN8rTTypsSIDs6NZJsZxRTJ4Rrci3r/paHoDby7upnU/PuqzrfpSI0hqVa
 mwubLVx6JaASVR/R4yK3+7agj47eN2NC6ybcRbGRGYKXfhnQkcokBv8898rqcVuZyyqu
 LhhtAT7smzflW+x3HsqWZimDM0KlZ96qKF6qbI2x9oV6HNw0Z3wIa6EiE9vbDoowJTKL
 C8ig==
X-Gm-Message-State: AOJu0Yy3xn8kCeXEt/eKm4wSiG2GaQPOT2lrggwv7P0EXNe2ncKbly29
 7T6rzFWMiZ6usfqdbgghMiQYTY9fPYZSZuWGkPlQ3Mtm7L6m+Mj7Hj1WXdnRHa37QICeW0arcpU
 vIbMGtceIhXREzk9RUtdd8fMaKZs=
X-Google-Smtp-Source: AGHT+IGJMmUUy8wHlPHxiLDg1dMz/EN+yXavYp9nyG70UB8/he1VXodL7oLLnkkToAWea05XSlJIbk9xTv7GKVn4kF8=
X-Received: by 2002:a05:6870:75c8:b0:210:7e88:f290 with SMTP id
 de8-20020a05687075c800b002107e88f290mr631970oab.28.1705607676942; Thu, 18 Jan
 2024 11:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-6-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-6-b6dd9704219e@linaro.org>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Thu, 18 Jan 2024 23:54:26 +0200
Message-ID: <CAGi-RULTVVdmgw9SCz1PXPeCoHVTSxd4agth9FRCGJrvJhqy_Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/32] serial: msm: add debug UART
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Tue, Dec 19, 2023 at 6:04=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> Introduce support for early debugging.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/serial/Kconfig      |  8 ++++++++
>  drivers/serial/serial_msm.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 81fdac047824..20713812c839 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -304,6 +304,14 @@ config DEBUG_UART_S5P
>           will need to provide parameters to make this work. The driver w=
ill
>           be available until the real driver-model serial is running.
>
> +config DEBUG_UART_MSM
> +       bool "Qualcomm QUP UART debug"
What is QUP ?
> +       depends on ARCH_SNAPDRAGON
> +       help
> +         Select this to enable a debug UART using the serial_msm driver.=
 You
> +         will need to provide parameters to make this work. The driver w=
ill
> +         be available until the real driver-model serial is running.
> +
>  config DEBUG_UART_MSM_GENI
>         bool "Qualcomm snapdragon"
>         depends on ARCH_SNAPDRAGON
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index a22623c316ed..19a5a3a788f7 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -253,3 +253,35 @@ U_BOOT_DRIVER(serial_msm) =3D {
>         .probe =3D msm_serial_probe,
>         .ops    =3D &msm_serial_ops,
>  };
> +
> +#ifdef CONFIG_DEBUG_UART_MSM
> +
> +static struct msm_serial_data init_serial_data =3D {
> +       .base =3D CONFIG_VAL(DEBUG_UART_BASE),
> +       .clk_bit_rate =3D UART_DM_CLK_RX_TX_BIT_RATE,
> +};
> +
> +#include <debug_uart.h>
> +
> +static inline void _debug_uart_init(void)
> +{
> +       uart_dm_init(&init_serial_data);
> +}
> +
> +static inline void _debug_uart_putc(int ch)
> +{
> +       struct msm_serial_data *priv =3D &init_serial_data;
> +
> +       while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
> +              !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
> +               ;
> +
> +       writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
> +
> +       writel(1, priv->base + UARTDM_NCF_TX);
> +       writel(ch, priv->base + UARTDM_TF);
> +}
> +
> +DEBUG_UART_FUNCS
> +
> +#endif
>
> --
> 2.42.1
>
