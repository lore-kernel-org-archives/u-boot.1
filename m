Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE723C54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 05:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FCBB880BB;
	Wed, 20 Mar 2024 06:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GNgM7ynO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED52E880BB; Wed, 20 Mar 2024 06:45:01 +0100 (CET)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62235880E1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4768156d947so949022137.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710913498; x=1711518298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fXJtuq//xSV7C7DTPzmHGETI7qzcGyx4jiZf06gZj90=;
 b=GNgM7ynOWu3nFchZG9LlQrgYJ4KIjE3iFO8wfQx2fjAYTKV2WXfXFkMj1JuCXyCKdx
 aKfc/emilgnAw6kA8vVhlvVC+3HKDXI7psGydjmNxm9aeWCOGEHkfJldsxFACDu39caB
 Ikc6uSpP4M5Dem9Y17XRQTG0oGDsA76F9zkbPwiLwXzs7sw/4nozQeaa7Gwv8u1lQCWg
 3AYdEk87F982nsox+7kNxXRg2THYkMjCemM8RJ4wZhs8kwnljnuhBZhaH4VGbGbZcxfq
 bi5o1k1TVeK5GHJ4RhMh/PjrtEdeEI8GEi8/ujfr43/tTEgZ7Q1lO0pGKDiav6VLcDld
 EMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710913498; x=1711518298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fXJtuq//xSV7C7DTPzmHGETI7qzcGyx4jiZf06gZj90=;
 b=S00UQnlrTtMr0JDGk9PpbuoRnwC5hPonB3er5iBdb1c2WhDnrtb9dWgeTBxgup9H2g
 fXkt+fP/aobHYTEzebeeCJhHy0/hXg3sStYYmVrqrek2OVseYB/JizDF8+Np0s0j6R/t
 ED6HdUZAhzzLtUntnM3Kh1kd0/oidz573HlIIHawFXiL8GnXPw2dZ8fPVEUq6FxENoPw
 1Duv0a1tMsz0dVRcuyaEotwCpJZc7a6zUeAEBM8S4N+zJisJNuMO1Y/YsJwDtP7Fg7QV
 UBd5D3bzs6SWa7j+59hnJ/BZHaSeWO4rsksksPeeiZRpjECBgVmztCbYRgJ31OYIMSsX
 5waA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+e09JD7OtsQdBZcfj4D/4emNvq+DZ9n0MIP9ZZ5OxH98t84dzUsiQw/k4aTAbOj4rgGLcVaM37ixgAv6mkzWXvZA5ZA==
X-Gm-Message-State: AOJu0Yy/4ndHUO+V1qhci4y1Ob9KyJ5Ezt3bhbwPLCnJZgquojROpBKP
 Zb30kn8PSwza414EhqIVxdoJpI3WQqH3yj6Ri4rozId5xf613sifD/sLe91aaTWHa2JjG+Medw+
 oVTj6yPoqMgTWK7df5UwfH+vxpaf2bkPSfgbTJg==
X-Google-Smtp-Source: AGHT+IEQdbbxDcfICq8p0KxquQeBAgetCloQjcVu0csEwGfwmvgOd6PYPMLke7Y1n32UIfYCzhhdEwD2eKaTZLi2O3o=
X-Received: by 2002:a05:6102:4192:b0:476:b180:5cf0 with SMTP id
 cd18-20020a056102419200b00476b1805cf0mr774263vsb.34.1710913498279; Tue, 19
 Mar 2024 22:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-9-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-9-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 11:14:47 +0530
Message-ID: <CAFA6WYPhnHaP9Z9Qeqzaz6ts+q3nTpck8QqeJk5EpcoyVktU1g@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] serial: msm-geni: support livetree
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> When using OF_LIVE, the debug UART driver won't be probed if it's a
> subnode of the geni-se-qup controller. Add a NOP driver for the
> controller to correctly discover its child nodes.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/serial/serial_msm_geni.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index 4aa0bc8c72bc..5260474fb9a4 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -605,8 +605,21 @@ U_BOOT_DRIVER(serial_msm_geni) = {
>         .ops = &msm_serial_ops,
>         .flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };
>
> +static const struct udevice_id geniqup_ids[] = {
> +       { .compatible = "qcom,geni-se-qup" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(geni_se_qup) = {
> +       .name = "geni-se-qup",
> +       .id = UCLASS_NOP,
> +       .of_match = geniqup_ids,
> +       .bind = dm_scan_fdt_dev,
> +       .flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> +
>  #ifdef CONFIG_DEBUG_UART_MSM_GENI
>
>  static struct msm_serial_data init_serial_data = {
>         .base = CONFIG_VAL(DEBUG_UART_BASE)
>
> --
> 2.44.0
>
