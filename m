Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA08C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 13:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E4728191C;
	Wed, 12 Mar 2025 14:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LlM7kg42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37DF280756; Wed, 12 Mar 2025 12:51:19 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A8C801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 12:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5495078cd59so7388832e87.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741780276; x=1742385076; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lk7zENClZx7SLMEKWDiQdyGueTi+Pai7/AFdLQwBiJk=;
 b=LlM7kg42rjggTmPBlwKvaXfF3nYqLn09aBGX+tFWeIO1yLrF/vTdZxt4PiY9pu1byf
 R2XKk6DWZ2cc0VlKXeQ6NFGzJExfdbFYZ/HBSRFxLTJXwgdtRKU5RK3wjGoPOy7kG6kK
 ovfq5sK65zBansXWuiZ3XwzFd9mSTeHWyUa2b0DtEr1hgmDbXRthoOrlesYC/sENaxLI
 qxFuenifbNPhjdiqWWWPDIsBBE49U6Kl7c22c5Z7GzhEa0gnSNblAwJwE9mHzhIIda3y
 NjO5uMU4H1qm4nTM65knspf5BQELHx0y+pqPLoTzT1ZxNoeLFV1j2GgHEhFHTzL6vXHX
 0mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741780276; x=1742385076;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lk7zENClZx7SLMEKWDiQdyGueTi+Pai7/AFdLQwBiJk=;
 b=wNTJTh6THehd02XgHOml9gW5yDfmuW+PKEsI16eBnaPVB12R+ZKzAQZUTQRyuzUrir
 +4MYxYcwG3tUu8j+TEa6SuJUj0PI0tx7dTXeWwGConFoguqOMqXO+uTabL+dGQSBoBbw
 xkfxNXdbqNCaE33DQ3mdtppSD1+LDicyONso+Fg9t6fv0dJiehee/MT6q/zoOjHozeCQ
 pIBVeOPXdyWX5ZXYusnomF0J3BHQP0jwHWvrnVMH4P3+71NQcDSKy19Zcqo7Qlo0Mjw9
 nDzOqD4UkbPhdxqj21a9IkMCbaqyjEF8YOg5pfbvbTzOLeImc+bS29G30W9d4lGeeSiQ
 YU/g==
X-Gm-Message-State: AOJu0YwVO0Bv0WLAUSAi0E5qFmmV5YtxbeAkRzy2ed4MebxSU8BqD47F
 KAsQk/9QE5DqRNxeahW1+WDJfcqjtu6zLsWyF6sCwI6MTtg6GYqtioAtzvAGbrFQUqv6G0Vj2H3
 hHhdWC6d4rqtYbXoMWTM53UYh+Z4=
X-Gm-Gg: ASbGncuaVn5+sNblF1YkDh/UMq9UdfH2HBC6q4vukcE0GsSXU6aX5qw5XMEl/+BaGk+
 2ncyT9waKnve0azPQ4j6MI7cB8uAkAvU39qhNxbPiJkjPrYQRob/PpGQRPPSfmNSdFN8TxiGhrY
 5ecb86MLHDAGoZtfxpCpStc9x6Ww==
X-Google-Smtp-Source: AGHT+IEINfPSJnXdLOIswrSP91a+yuNPm4O9LjKmBmIt/2FQmN8Vlv3wLogXjkAgUVmw3kKSAfM5/CgD087JZMEsSXY=
X-Received: by 2002:a05:6512:1094:b0:549:912a:d051 with SMTP id
 2adb3069b0e04-549aba2a91emr2867773e87.0.1741780275571; Wed, 12 Mar 2025
 04:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250311133506.124914-1-mchitale@ventanamicro.com>
 <20250311133506.124914-2-mchitale@ventanamicro.com>
In-Reply-To: <20250311133506.124914-2-mchitale@ventanamicro.com>
From: =?UTF-8?B?0JzQsNC60YHQuNC8INCc0L7RgdC60LDQu9C10YY=?=
 <maximmosk4@gmail.com>
Date: Wed, 12 Mar 2025 14:51:01 +0300
X-Gm-Features: AQ5f1JpmcH43oxurVS5kIZ3CWWgp4wgnqv3YDJ7SByQbu7gxGPRtEx_WIIx3LxI
Message-ID: <CALUeBeDZFnKHT14FwrpmhqzFDOO3vCzqJA8XRTzAEdCwOSApRQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] riscv: image: Add new image type for RV64
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
X-Mailman-Approved-At: Wed, 12 Mar 2025 14:01:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

=D0=B2=D1=82, 11 =D0=BC=D0=B0=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 16:35, May=
uresh Chitale <mchitale@ventanamicro.com>:

> Similar to ARM and X86, introduce a new image type which allows u-boot
> to distinguish between images built for 32-bit vs 64-bit Risc-V CPUs.
>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>  boot/image.c    | 3 ++-
>  include/image.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/boot/image.c b/boot/image.c
> index abac254e026..03d5e59b634 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] =3D {
>         {       IH_ARCH_ARC,            "arc",          "ARC",          }=
,
>         {       IH_ARCH_X86_64,         "x86_64",       "AMD x86_64",   }=
,
>         {       IH_ARCH_XTENSA,         "xtensa",       "Xtensa",       }=
,
> -       {       IH_ARCH_RISCV,          "riscv",        "RISC-V",       }=
,
> +       {       IH_ARCH_RISCV,          "riscv",        "RISC-V 32 Bit",}=
,
> +       {       IH_ARCH_RISCV64,        "riscv64",      "RISC-V 64 Bit",}=
,
>         {       -1,                     "",             "",             }=
,
>  };
>
> diff --git a/include/image.h b/include/image.h
> index 8a9f779d3ff..12b31166e86 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -139,6 +139,7 @@ enum {
>         IH_ARCH_X86_64,                 /* AMD x86_64, Intel and Via */
>         IH_ARCH_XTENSA,                 /* Xtensa       */
>         IH_ARCH_RISCV,                  /* RISC-V */
>

I believe s/RISC-V/RISC-V 32 bit/ is more explicit.
Looks good.

Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>


> +       IH_ARCH_RISCV64,                /* RISC-V 64 bit*/
>
>         IH_ARCH_COUNT,
>  };
> --
> 2.43.0
>
>
