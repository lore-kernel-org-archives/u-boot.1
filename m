Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED4ACD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 08:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 639B887FA0;
	Thu, 11 Apr 2024 10:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VMQzUFKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D1188334; Thu, 11 Apr 2024 10:37:05 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE25D86FCE
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 10:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-516d68d7a8bso555444e87.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 01:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712824623; x=1713429423; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lKpgCSOtbrGE3i2CGMWjUE+cBkA4j7LYrqGpfSA9Cc0=;
 b=VMQzUFKH415L2SVIkNEjd3VHtxJDMLxrQfLMirajSgugUSpo1AzDy0jjBOp9UJVln2
 GEg5TVHKIYdk4MfUe+4t2/JG+UH9348Ib1Zr4X8pN5I/KpwtT6F4QKkpu4fhYI2lEpvM
 eLSZz2Uj/myF6gDqi46umn1TwTP61/9hz1L8CmBKevSELIyj5gIcvTwd4WR/GkWjIV/E
 ZsycHIvoeOl42xHeK1tw1ZjaU65HCG7+jN5CWLnREj5xlmXIDVOkPKV4E95NLQadsDlb
 Uaejaov4Dtcw3PcdHayoeeTu7uA1eK0fWXaYUzEu2NT5FIchMje0iW2H292LR4SaEY7E
 7ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712824623; x=1713429423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lKpgCSOtbrGE3i2CGMWjUE+cBkA4j7LYrqGpfSA9Cc0=;
 b=FozuBpbAIqQkJpMD3+sB7/3dzlAZPvA1RPB+aewg5LN2Ma7f6w4Bu/snkXLKDMu/gD
 HUuXCXsxqA3RVtyAi261g7y9B+NIYtsBDdb3XtnkQJMNt331RR/VQd+XqeKViSI+KHDI
 T/PtcbzzXzsOYFYBUjVn60CaKc3XJNawyfA/+VJ164VPO2a+qBtzwuDOLt3yJqpdFUlb
 XxstHQ3qw2pIiK4Dt8aytahaFxTKnFX2yz8R0EfQg+roxEITi+O5m6sY8eAFuW7LV5Vu
 KCPIjYCiU6OVuCObXHRP3hC2x7RMQlc1J27BCOnpKSsFhRZo2YNwKss1cG+DBY6iFq5Q
 u97w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7JeCEkAn2igp+thu6LGXta226sfrtsTZoc7NCHKKLXMUa4si70g8xhnkrRQYKKCSSOUkSHmzYdldSgOxTD5MXw5A+GA==
X-Gm-Message-State: AOJu0Yz4raVi40ZWhYu4RszrlG3Lhh3NT0gkk9SRnpVpAO1NSoHSY88Q
 a0oYrUOEEMYuE2QmuvOkJb9MU/MtDBcuIzbGrmAQDg0Pe+dhohSRFz3y5ZDQ1+fjqyGlkqgY+Ft
 8f/vdpSw/N80D8C0JLx1JWHeL17t0SykrLUJZK32Z4Kn2zzEOqlTFTw==
X-Google-Smtp-Source: AGHT+IEtK+Gzzx3TEWTHn/DQPIv2AnO1dMZKbENvXZRV7arT9k1VQBUzrDi7Iht7I1Tx7qsaUlI0kUT5l49cEVGqoYg=
X-Received: by 2002:ac2:4894:0:b0:516:c1fb:5ea7 with SMTP id
 x20-20020ac24894000000b00516c1fb5ea7mr463604lfc.14.1712824622927; Thu, 11 Apr
 2024 01:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240410225043.40100-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240410225043.40100-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 11 Apr 2024 10:36:27 +0200
Message-ID: <CAC_iWjKP8oq0nG0j54+Z8TP2bxhzZ2wMxH0zdQepy3p__TBLdA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: sanitize efi_tcg2_final_events_table
 definition
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Eddie James <eajames@linux.ibm.com>, u-boot@lists.denx.de
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

On Thu, 11 Apr 2024 at 00:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The length of the variable name typically is not 1.
> Neither the length of the variable name nor the size of the appended
> data is known in the include.
>
> * Define the size of element variable_name as variable.
> * Remove the unusable element variable_data.
>
> Addresses-Coverity-ID: 467400 Out-of-bounds read
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_tcg2.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
> index b21c5cb3dd6..a75b5a35b6e 100644
> --- a/include/efi_tcg2.h
> +++ b/include/efi_tcg2.h
> @@ -150,16 +150,14 @@ struct efi_tcg2_final_events_table {
>   *                             the variable.
>   * @variable_data_length:      The size of the variable data.
>   * @unicode_name:              The CHAR16 unicode name of the variable
> - *                             without NULL-terminator.
> - * @variable_data:             The data parameter of the efi variable
> - *                             in the GetVariable() API.
> + *                             without NULL-terminator followed by data.
>   */
>  struct efi_tcg2_uefi_variable_data {
>         efi_guid_t variable_name;
>         u64 unicode_name_length;
>         u64 variable_data_length;
> -       u16 unicode_name[1];
> -       u8 variable_data[1];
> +       u16 unicode_name[];
> +       // u8 variable_data[];
>  };
>
>  /**
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
