Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5A1C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 06:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BCD883BA;
	Wed, 29 May 2024 08:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TdTjBuso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B8D28858B; Wed, 29 May 2024 08:44:41 +0200 (CEST)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F36A5882B4
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 08:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-48a39be0e32so524853137.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 23:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716965078; x=1717569878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SaXQ0jpJidIYxCM7ZDDKEqr+ZVTW9W4he8Huad2Mq9A=;
 b=TdTjBusov3GWNO2tQdIPwTfJDEEP8NHJMpoD0i+XwDQs0aqmFL2IqNylT+SKpEHe8k
 HQZKUJkZ+W6YtLwgBABanEdyRhVoUpepctn7QjE0LHEGNL9fzNoZAOsyUC9b15Uk/Z2x
 71coEGJMrmIuGNA2uW5Om5p2uSZsjUNHDjf1qWJUBpYNF7Vfp3IpNLnC6m3bjcOYdPRv
 9lbJHYgCRPCq8S3cbXq5p6GguaQnsdGYW50cjfeDjrURT+f2mWGRO+DcN2pa2zLlwqi9
 lOb1/4QSk6gxAo/xw5+NzYKXMAcWzrh+f2hc5c8gFTGQYrHjlztiPOQdSVFKlx8t71SQ
 WzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716965078; x=1717569878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SaXQ0jpJidIYxCM7ZDDKEqr+ZVTW9W4he8Huad2Mq9A=;
 b=AyJUSI6l2Xy95lutfEJGMUEsxOhikaXnzEl0KoootgEF7Bngkr7n2ighVT39jjlSyl
 CJyYtfTVn+7SB4ubFXz2d/Qg6f+g/V3MrbkbeIbOEgRNw+DSaaZLunLwzIBqkERDE6Tx
 BsHN7HRTljTbQm7XSqoGFhrhoVwz6NAexodnb8YQkBwZCRvF4NACVb0FurDrfzqJgYOz
 0VSIyzLM60VKaTMCQRrogFhTY5T6HlvbhaTHIIoOne3nZhW/SQeXWntdVe2IaVO3X1/q
 A6B5/6RJZ547lDDdbd/z+8/MGc7XE8uPjMQOfYgSTpBJvZh0Dv0+f+d2Xr5EoWaNS8Rr
 iTJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk8aInyaq26KNRgxlxVH0c40yJdjBbB5fcveWPnwqdko8ECk86Gv5PQtz+/UOymySpyRyNAwH914t8/ZMDP4bdq6Fukw==
X-Gm-Message-State: AOJu0Yxkp7Z3Ut+Q/9romGNfqjR5w3BmEps705/qB/A1hyRQ8pYYLg6t
 ACfa2ApNUVEZc+n7ZLojoF4rJ9xW9gC3GmltNDkxxKOusz+vZhJK/8+PQBi3VmKorexbi1WYPuX
 n08+ZscVKRO1v+9naYRBMbqjxBnFQ+m1g4VdVIg==
X-Google-Smtp-Source: AGHT+IGKBrHxqgcbM7KVaSFdz2dkry01Da/zxNWzt9qLI6qQfsboZQbI9yVmX3uNPpZgfgUY7sFlx5JRlkMy9kVzfSE=
X-Received: by 2002:a05:6102:1897:b0:47b:d787:9ca6 with SMTP id
 ada2fe7eead31-48a38575d48mr13686670137.18.1716965077757; Tue, 28 May 2024
 23:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
 <20240528-topic-sm8x50-pinctrl-pinconf-v1-2-54d1e9ad7dfa@linaro.org>
In-Reply-To: <20240528-topic-sm8x50-pinctrl-pinconf-v1-2-54d1e9ad7dfa@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 12:14:26 +0530
Message-ID: <CAFA6WYP=hD9YC+Pf4-_gY6Da4HS_nGziB8ejFqdxESp69beRJA@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm: mach-snapdragon: gpio: introduce
 msm_special_pin_data
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Tue, 28 May 2024 at 14:02, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> In order to help setup pin configuration for special pins (UFS, SDCard),
> introduce the msm_special_pin_data struct largely inspired from the
> Linux conterpart but with only U-Boot required fields.
>
> This struct is added to the pins_data to allow specifying the special
> pins data for each SoC.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm/mach-snapdragon/include/mach/gpio.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/include/mach/gpio.h b/arch/arm/mach-snapdragon/include/mach/gpio.h
> index 53c6ae06490..cc8f405e20b 100644
> --- a/arch/arm/mach-snapdragon/include/mach/gpio.h
> +++ b/arch/arm/mach-snapdragon/include/mach/gpio.h
> @@ -10,11 +10,25 @@
>  #include <asm/types.h>
>  #include <stdbool.h>
>
> +struct msm_special_pin_data {
> +       char *name;
> +
> +       u32 ctl_reg;
> +       u32 io_reg;
> +
> +       unsigned pull_bit:5;
> +       unsigned drv_bit:5;
> +
> +       unsigned oe_bit:5;
> +       unsigned in_bit:5;
> +       unsigned out_bit:5;
> +};
> +
>  struct msm_pin_data {
>         int pin_count;
>         const unsigned int *pin_offsets;
> -       /* Index of first special pin, these are ignored for now */
>         unsigned int special_pins_start;
> +       const struct msm_special_pin_data *special_pins_data;
>  };
>
>  static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selector)
>
> --
> 2.34.1
>
