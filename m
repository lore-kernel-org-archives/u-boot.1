Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F599C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 04:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B01586FDE;
	Fri, 17 Nov 2023 05:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DPnXUsN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E5286FDE; Fri, 17 Nov 2023 05:30:20 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E8286E7A
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7c1a46c943cso240036241.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 20:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700195410; x=1700800210; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iYkGExnvp0MGH4QIH3jDlUw+LFznHMmJBldZUhG1LiI=;
 b=DPnXUsN2bUE7ppw5AtkJBTt/gt0CKMjeQkOgcfmpC7DHQoWC8AtGCW63aOhMwPzbKx
 xNX2KHoZ4fs5t+EiD4lLITpvOxR6GsaQGsS7yyHEnL82gXGkN6SSKyThDjR95KUcyEzX
 JEFI1E15gmjCyoYIAdMNWXY/voMCvsQ4eVwYFfcqzTVn5whJJHMVW2gm7ZKdwkK6qFYh
 b7PVx0qjr7VKlz5eDYGbnMv9PGxSXzYG8LQ3+31m2MpL3011oThyvY7jKzSF+2koRzzP
 z2/cuviVnW6qrO8VTCtcfE8iyul7Vwh/u1EIKhU1JpdgRZo5GN1//LZKSxT3uceor44V
 yj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700195410; x=1700800210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iYkGExnvp0MGH4QIH3jDlUw+LFznHMmJBldZUhG1LiI=;
 b=rbrRMLW6+R7j3pFeDHVWhahLmanQa+XVLkxo8hK31l7oISE4NzjUGzNhaGljXmirgc
 asOlKBl4AxQzK5AHFcYxV+u7FdmPiGNffh0m3hxpOpWoMxwYU9YzEuAGvG4THBg/sbWF
 bD9hNerN2ChhszJbUzmVwN2l1jJAYAS/o5wdm3U0ysSJCMj4z9rB8oScyocuP6jSTswz
 oC9V1oBDzMONXmgBIKuzuwRTPj2hJ2TZFvoYiqUpb+3P+mbSIlqQ+dcNDvwTgbzyEVUH
 iIAhbOPDVuWn/Tjcbi3iT092dO3C3jfpSy5CWIOtpOV4Ldm4V2vUn0zzcFvTXUD6vPIp
 /QyQ==
X-Gm-Message-State: AOJu0YwZZHSfJbXvypteyR2BorHGbrjsfspTluQ60CszACt/m0BxoiWz
 yGnZ9EeUhRmWtadW9IJ4ps1PYRlLIt8MCJcLMcjw7A==
X-Google-Smtp-Source: AGHT+IEsFzLt01L5ppKTiayihZbbeNwrSBI/VNI0zDG8HFlEADtwzto8fdlVzNEl+e8ml6+LnePYlMfnr4lKWVmhyAU=
X-Received: by 2002:a05:6122:20a5:b0:495:ec90:997e with SMTP id
 i37-20020a05612220a500b00495ec90997emr21149945vkd.7.1700195409987; Thu, 16
 Nov 2023 20:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
 <20231114-b4-qcom-dt-compat-v3-1-88a92f8f00ba@linaro.org>
In-Reply-To: <20231114-b4-qcom-dt-compat-v3-1-88a92f8f00ba@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 17 Nov 2023 09:59:58 +0530
Message-ID: <CAFA6WYPfTCG1DYd1KkLk7K3TZrTHs8k5K4B8uAYJNtRQhS1SEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] gpio: qcom_pmic: fix silent dev_read_addr downcast
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Stephan Gerhold <stephan@gerhold.net>,
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

On Tue, 14 Nov 2023 at 19:18, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> priv->pid is uint32_t, but dev_read_addr() returns a uint64_t on arm64,
> with the upper bits being used for error codes. Do error checking before
> downcasting to u32 to prevent errors being silently ignored.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/gpio/qcom_pmic_gpio.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 65feb453ebc3..e5841f502953 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -221,11 +221,14 @@ static int qcom_gpio_probe(struct udevice *dev)
>  {
>         struct qcom_gpio_bank *priv = dev_get_priv(dev);
>         int reg;
> +       u64 pid;
>
> -       priv->pid = dev_read_addr(dev);
> -       if (priv->pid == FDT_ADDR_T_NONE)
> +       pid = dev_read_addr(dev);
> +       if (pid == FDT_ADDR_T_NONE)
>                 return log_msg_ret("bad address", -EINVAL);
>
> +       priv->pid = pid;
> +
>         /* Do a sanity check */
>         reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
>         if (reg != REG_TYPE_VAL)
> @@ -328,11 +331,14 @@ static int qcom_pwrkey_probe(struct udevice *dev)
>  {
>         struct qcom_gpio_bank *priv = dev_get_priv(dev);
>         int reg;
> +       u64 pid;
>
> -       priv->pid = dev_read_addr(dev);
> -       if (priv->pid == FDT_ADDR_T_NONE)
> +       pid = dev_read_addr(dev);
> +       if (pid == FDT_ADDR_T_NONE)
>                 return log_msg_ret("bad address", -EINVAL);
>
> +       priv->pid = pid;
> +
>         /* Do a sanity check */
>         reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
>         if (reg != 0x1)
>
> --
> 2.42.1
>
