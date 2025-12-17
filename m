Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC12D65548
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 10:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1460A839FA;
	Wed, 17 Dec 2025 11:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kdfSw6gE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F9383AA0; Wed, 17 Dec 2025 11:40:36 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C7083979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 11:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-786d1658793so52357717b3.1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 02:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765968033; x=1766572833; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+jfS+eF7VjHxQ4vO8fl+EjSjX/8aorKwEO3XxGwalK0=;
 b=kdfSw6gELo03CkJsm8IOpKkn3j9FNMtkyBjaEHPurzC3FLtFnJ+m9fyVujp5CGFtJy
 /GLIlCVfVricG8fubp/HSUTKEB0sF7nTkb23RNELUXPySR99PaBXewEeSWOw4lJk+ShC
 YpjgA1oYkS5jEik4nr8dHcTIzEYRPJRYuFELlEbiYsSZQF+dPHbAtRZhpxD2o8RVDSyE
 5QaOZip3vfe2+Fb36WsiBe27AMXYJydxlofCb3x2DhLhZea1H0k70jbDiCqEN0KAwbpS
 rlORZCK3b+pT37fx7WKAFwsSNeuv5cS/piFZN93szF8s+eobsWrNqc/6Ckk8HKALq32Y
 CnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765968033; x=1766572833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jfS+eF7VjHxQ4vO8fl+EjSjX/8aorKwEO3XxGwalK0=;
 b=R5UTRg38FHKLn03DiXZxCtO55cqKiO1nEYMco2qCvOd562UZY1S3PanP+MgsCcb0ao
 +blyLuPBCL1q08loJIq36wjY+NplrWjsD2rHjVePCpNAtouK6j626FMZ3pLVRAy8L5hO
 i0ZvIJKo/Oy7zdy7OH/glBZuicWgwYgQ1KKt666LnSeEro/sSPDyiAFbrWQ0hl4qh0O7
 TNjCYg/pxNTJ5qDOkgAco/hlgvC2Obu2GMQbMWR6bu550nAHi/9VatHXz8slv9HVyhub
 rUKl4GdStFtmw4nIFkMsqFng6t0JKy21VOtOwSgcf/v4Z9hbt+ylTmUCCRr8eyDZuVZL
 UKDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCwaKyxWjQW6rGjNJKTztIiLlmNn4tOtKe/I2NGdxYhOVVDJ+bQvr2bjshSf4p7SKWPB3eeco=@lists.denx.de
X-Gm-Message-State: AOJu0YwTYgm0ftLILqJRF1ZzOlJR96flqBwCSWlI47Gylu1yV/+YU9Ta
 pCUS3hnDRaKta2S3Wjz6tMg7SqJBj2zrs1bw1fK9o8jVYdRSmZ6d6SX4PNrIuhWEVs7iMATA7DI
 4WvUlmqiz1sxaWziqn5WvHUNWUe61GRugcBNRNzNbcQ==
X-Gm-Gg: AY/fxX5gAcQguFXPeiqpa7OWq4L8u7zsYLKRRrbS2KgCAmWLhdOxBSCT+0Yviop8roV
 tjs8NCpzRkBi9E2oL/J2XF0zPjvgk2ieJbdvXd5gj9/G/GgJYEj6oG5f+O0w0CPe2/yg9sFkLnP
 TApzk2PEaybVvjDMhiT0Q9ljJ4UDuW45qrnjYkGL1HbwospJ3n8i0w/ztk0Pn/G+a6PBDFBT6cs
 f3i1R9BeMH3cPzfH/SqYgkko+BvrHDXUdWbI21opQj7r59Qs9WT3mV6u590FgbSGwwLRoL0dJK+
 tHbfl/ExCIXpkMUtdzMfBBO6SIT3CH6p9T96d7694eeDaQ/zVYmP8lQ74N8bMJidrJ3zV6Ys871
 QhJck3Gq9BawMrdGtN3uiQLZngXI9ER1rX1HUcXZd8Y4cgYVP++PsF4ZyllI9pzTk4u6hhz6o15
 wryJJGOeAV+eyetYHCC9887qtvrzKZ+1xSh3y+jycmv/DfvDrw8A9a+sUWaKvXAfMNAmZ4Yxy81
 Ntjsq8xloPz+MMlJB2VwOizjm7QRa1cStvDW0qX5wurR1x6u0mFcTEdrrWtYqLGiEFnKoM9qhoF
 zbUwJmNVRXXtsXxLsRK7LpjGsN/EjcY9kpUR/G55fCU=
X-Google-Smtp-Source: AGHT+IF7nV2sk0a41J7UC9fSvZdTAcsawcJgQF8iiuvvFDwb5Ht98G2eccKnUSG6rHdbs8nWaMQqmOKCoJ7epiWquf8=
X-Received: by 2002:a05:690c:2506:b0:78f:8afc:c34b with SMTP id
 00721157ae682-78f8afcc97dmr74951907b3.34.1765968032915; Wed, 17 Dec 2025
 02:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20251217072558.2949569-1-patrick.rudolph@9elements.com>
 <20251217072558.2949569-2-patrick.rudolph@9elements.com>
In-Reply-To: <20251217072558.2949569-2-patrick.rudolph@9elements.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 17 Dec 2025 12:39:56 +0200
X-Gm-Features: AQt7F2rYsgC51eTFkHd_J1sCt28AN6EO28XrdDYUz7NhNgJBLmZfsLkym69hysA
Message-ID: <CAC_iWjKceKOGbZFVuYSTVvJkmW2yA8Aa9O7xECL05FRXrywSow@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: Fix kernel panic when FTRACE is enabled
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
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

Thanks Patrick,

On Wed, 17 Dec 2025 at 09:26, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> When FTRACE is enabled the EFI runtime will call the tracing functions
> that are not marked as __efi_runtime and cause a kernel panic since
> the functions have been previously unmapped by the kernel.
>
> Resolve this issue by adding the 'notrace' attribute to '__efi_runtime'
> attribute and thus disable tracing the EFI runtime. If required this
> can be worked out latter.
>

So I agree with this. Fixing is just a matter of moving the missing
functions to the runtime section, but I don;t think it's worth it,
unless someone *really* wants to instrument runtime calls.
OTOH runtime calls in the OS are rare and very limited

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> TEST=Can boot a UEFI compatible linux OS on qemu-q35 when U-Boot was
>      built with FTRACE=1.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  include/efi_loader.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3e70ac07055..7a13c390cbe 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -66,7 +66,7 @@ struct bootflow;
>   *
>   *   static __efi_runtime compute_my_table(void);
>   */
> -#define __efi_runtime __section(".text.efi_runtime")
> +#define __efi_runtime __section(".text.efi_runtime") notrace
>
>  /*
>   * Call this with mmio_ptr as the _pointer_ to a pointer to an MMIO region
> --
> 2.52.0
>
