Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11400C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 05:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B227880AD;
	Wed, 20 Mar 2024 06:22:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M++KG8FJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31DF888099; Wed, 20 Mar 2024 06:22:01 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B746B880AD
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-476573535f9so2611159137.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710912116; x=1711516916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dSYetfhspsbEZP/fK6rVlCHSlky18Wbl7Zyqjfuj44M=;
 b=M++KG8FJ9k8tGStvKofUjVy4tIJapxPy/oOoSaGN6J65sSNV6WwG0/X98bImMmR83R
 ICNcBI8XAgGWnaD+MPJvm4oaIsqXnaaOX76Lm8GJirBR1ih5txplGsyCIbH/wL7JQt/4
 qZZPZ4yOllnQT9nuRUfrKn3Dz34YNzS3s0DqM2qX9jv0myXt6PGkMkiC2f3tKLqYVw92
 Gk4neeZIiAlIpfMtfLgLfKO+0V1aP/iWTmWjCy4PiYECt2gFlgypshZTHrAo5ZJCAGxA
 14zfEkku7If8stNbKYK7MzPuY+VVhg6HXBPM0xlDuUBtyYdVV5Jy+UGM06uZoQtGme65
 wgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710912116; x=1711516916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dSYetfhspsbEZP/fK6rVlCHSlky18Wbl7Zyqjfuj44M=;
 b=vVwc1uSFkrdsaYwD/qc8cctad+NJPe50PIOU9I5VaabNiEm3kOvZNTJZjXt3E+oVeK
 dKKGgWbWX1dW5UvYLeG+bxgZB5y8qb/RQag6JBk99diZDV60J4V9y9fpjr8wzHx2DFd+
 wBzmuz6EYVY0H3GYONcXvKMzMHSizWeQc52+k52jn2UYoi3RcU+z/IJNEa6EPesKCFpm
 JhaZ2XakLAvSx4a6LZICCVf/P1ddwQpQfx1eLAeLiwgT+AJk3cD7kNWdzhWGYneUANBN
 ae+G/gooBH6O6/Jtagi/BfU8PRCFBGxiPCEcHowdj0DnHLk54XriocXmudUHfzuOr6X5
 zMTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2gQ5Ry/rSZRi0lCgkv9me6cvb0l+iGyV1RBwHrb27i8bcC+1GIa+gSfXzjTpluotkJBjp0/j3NMWVm2Uv/ItdDY49MA==
X-Gm-Message-State: AOJu0YwHDmvw+e6Pf8G0paSyE+SgNx38ODu0p9IF5ScHenAoM3D+ydLi
 v9MR/9EBHkGs+Pwhn+u4dgXKvP9yY3UhnziQ2NrSbD6uIiI25XXKfGlFSVE9zR/jSnHo07DvIDy
 i4dS9tTmnqUjV3hYw3bFztj8Jtb1TZtF8wRyb+w==
X-Google-Smtp-Source: AGHT+IGcQCreUdfafwcSEMhtRmhasDwBjzLGrEGePW2RE+bU8Ckm9WYLqdoKRtuTH0mlQmUnJgpwSgosHuXALzboB7U=
X-Received: by 2002:a67:b903:0:b0:476:a7e4:464b with SMTP id
 q3-20020a67b903000000b00476a7e4464bmr816113vsn.35.1710912115918; Tue, 19 Mar
 2024 22:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-4-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-4-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 10:51:44 +0530
Message-ID: <CAFA6WYOs=qHiungm=9wBDu-b3F7w8xrzN39aawvLsaviFr3=Eg@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] mach-snapdragon: disable power-domains for
 pre-reloc drivers
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
> Some devices like the UART and clock controller reference an RPM(h)
> power domain. We don't support this device in U-Boot, so add
> DM_FLAG_DEFAULT_PD_CTRL_OFF to tell DM core not to try and enable the
> power domain.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/clk/qcom/clock-qcom.c    | 2 ++
>  drivers/clk/qcom/clock-sdm845.c  | 2 +-
>  drivers/serial/serial_msm_geni.c | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>


-Sumit

> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 7a5938a06a34..6303dcbf8461 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -226,8 +226,9 @@ U_BOOT_DRIVER(qcom_clk) = {
>         .id             = UCLASS_CLK,
>         .ops            = &msm_clk_ops,
>         .priv_auto      = sizeof(struct msm_clk_priv),
>         .probe          = msm_clk_probe,
> +       .flags          = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };
>
>  int qcom_cc_bind(struct udevice *parent)
>  {
> @@ -410,5 +411,6 @@ U_BOOT_DRIVER(qcom_power) = {
>         .name = "qcom_power",
>         .id = UCLASS_POWER_DOMAIN,
>         .ops = &qcom_power_ops,
>         .probe = qcom_power_probe,
> +       .flags = DM_FLAG_PRE_RELOC,
>  };
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index 36ffee79d966..babd83119e2c 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -182,6 +182,6 @@ U_BOOT_DRIVER(gcc_sdm845) = {
>         .name           = "gcc_sdm845",
>         .id             = UCLASS_NOP,
>         .of_match       = gcc_sdm845_of_match,
>         .bind           = qcom_cc_bind,
> -       .flags          = DM_FLAG_PRE_RELOC,
> +       .flags          = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index e5c3dcffc1c6..4aa0bc8c72bc 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -602,9 +602,9 @@ U_BOOT_DRIVER(serial_msm_geni) = {
>         .of_to_plat = msm_serial_ofdata_to_platdata,
>         .priv_auto = sizeof(struct msm_serial_data),
>         .probe = msm_serial_probe,
>         .ops = &msm_serial_ops,
> -       .flags = DM_FLAG_PRE_RELOC,
> +       .flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };
>
>  #ifdef CONFIG_DEBUG_UART_MSM_GENI
>
>
> --
> 2.44.0
>
