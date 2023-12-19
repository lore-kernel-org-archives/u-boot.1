Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08325C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42369807D9;
	Tue, 19 Dec 2023 18:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eG/STg6Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC5B5871C3; Tue, 19 Dec 2023 18:03:34 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5AA9807A8
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2cc4029dc6eso57315081fa.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703005412; x=1703610212; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2rRQrwmLrPfWjkPfaFIT3ezmW8sVYr0s1EKkL2tR/nE=;
 b=eG/STg6YRuttKwF2mHa/srxGk7daGSfEWoYoDuYTx5PASSZHw/7ryhMujK+hrGqM5I
 grOaqggk+Z8cuFkv6xebaH7rVmrqRGpT4TXB2vwsA78dWULBvrtOoqZDNpGu6OMEAAeY
 sVAh+Zw//WCQyJSfiAmK1lE4YxGzjKcGRSecWViXR/hNp1PfKcXAkMX4g2Cda4Hx8Qa3
 eVOF54N9ORFh8weXfHPSh5uU8ic26dzBvUpTAlHHCWJLJHCMiycj0lfGlbvTfrpVIF3A
 Vs922lqD7lzgIiEWTUdlfkytEoEW1U/KhFrHnyr0JaTiGnxOV1r02tBMLkPWTK7MhpgM
 Jxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703005412; x=1703610212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2rRQrwmLrPfWjkPfaFIT3ezmW8sVYr0s1EKkL2tR/nE=;
 b=Z4VyhYrnDBaE0plMXlpNPMV70Mska/ROG2r2yWGTUK707VbYaiSv788lyHRrmEEO1a
 WcAdWPDuZQQTXd0Ue8XElJGDD0tPl6+3xaG8Xf7muHooDeCJ4KEysM4QXyB38Ckkf1Wc
 vUKr9XszsD7YrKugZSkMXP0c5mN1iz/ogAEDERZxwf+kx5IrO948ZEdE/Z1YkBoLp9Bw
 QaJWfamxSeDoDl5Q3J2edKkbU/+rlU+P8HPDhrwYfELrIiqBWSbcdCdWFsXdfvr7RWCb
 /V1vU8OT5r2iaJX9nHK0Zhp3mrFB+QfIQ9T1dNW6KQQX/hLO+pcetg+VoiRD3H1u7gvK
 whXw==
X-Gm-Message-State: AOJu0YyT/DgnaRlAGtY253N43nnGTErfFGWfcQMHC41E3tjVQex9s7oE
 YKhgejMl+vz5ZGAqLsP+ClEk9UzH6AQmU6unCgCvpit50D0XBjElg08=
X-Google-Smtp-Source: AGHT+IEmJI23fXFgsOda9IUcihQgXiys/SaxJZzQSJ8Vh1EKkQIb/cYMROAYLkRsvXzqMyHMtOMgqtOsMRNJThvs50Y=
X-Received: by 2002:a2e:9883:0:b0:2cc:5c96:429c with SMTP id
 b3-20020a2e9883000000b002cc5c96429cmr2887688ljj.46.1703005411933; Tue, 19 Dec
 2023 09:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231219150408.10949-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 19 Dec 2023 19:02:56 +0200
Message-ID: <CAC_iWjLV7PCjqz3dmfAWFqXeDJNK52-kYZBs-q6HnrcQXoP1CA@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] arm: add ACPI fields to global data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
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

On Tue, 19 Dec 2023 at 17:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add fields for the location of ACPI tables to the global data.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
>         no change
> v3:
>         let tables in global data depend on CONFIG_(SPL_)ACPI
> v2:
>         new patch
> ---
>  arch/arm/include/asm/global_data.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
> index 75bd9d56f8..c3d87caa0b 100644
> --- a/arch/arm/include/asm/global_data.h
> +++ b/arch/arm/include/asm/global_data.h
> @@ -19,7 +19,12 @@ struct arch_global_data {
>  #if defined(CONFIG_FSL_ESDHC) || defined(CONFIG_FSL_ESDHC_IMX)
>         u32 sdhc_clk;
>  #endif
> -
> +#if CONFIG_IS_ENABLED(ACPI)
> +       ulong table_start;              /* Start address of ACPI tables */
> +       ulong table_end;                /* End address of ACPI tables */
> +       ulong table_start_high;         /* Start address of high ACPI tables */
> +       ulong table_end_high;           /* End address of high ACPI tables */
> +#endif
>  #if defined(CONFIG_FSL_ESDHC)
>         u32 sdhc_per_clk;
>  #endif
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
